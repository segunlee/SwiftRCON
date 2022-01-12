//
//  SwiftSocket+Starscream.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation
import Starscream


extension SwiftSocket {
    internal func send(rustCommand: RustCommand, responseBlock: @escaping SocketReceiveBlock) {
        if socketReceiveBlocks[rustCommand.identifier] == nil {
            socketReceiveBlocks[rustCommand.identifier] = responseBlock
        }
        send(message: rustCommand.rawValue, identifier: rustCommand.identifier)
    }
    
    internal func send(input: String, identifier: Int = 0) {
        guard !input.isEmpty else { return }
        
        do {
            let packet = RCONPacket(Identifier: identifier, Message: input, Type: "SwiftRCON")
            let packetData = try JSONEncoder().encode(packet)
            guard let json = String(data: packetData, encoding: .utf8) else {
                print("Send failure: JSON convert failure")
                return
            }
            socket.write(string: json) { [weak self] in
                print("Write Success")
                self?.socketReceiveBlocks[0]?(RCONPacket(Identifier: identifier, Message: input, Type: "SEND"), nil)
            }
        } catch let error {
            print("Send failure: \(error)")
        }
    }
    
    private func send(message: String, identifier: Int) {
        do {
            let packet = RCONPacket(Identifier: identifier, Message: message, Type: "WebRcon")
            let packetData = try JSONEncoder().encode(packet)
            guard let json = String(data: packetData, encoding: .utf8) else {
                print("Send failure: JSON convert failure")
                return
            }
            socket.write(string: json) { print("Write Success") }
        } catch let error {
            print("Send failure: \(error)")
        }
    }
}


extension SwiftSocket: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
        switch event {
        case .connected:
            isConnected = true
        
        case .disconnected:
            isConnected = false
            
        case .text(let string):
            guard let jsonData = string.data(using: .utf8) else {
                print("Receive String Convert Failure")
                return
            }
            do {
                let decoder = JSONDecoder()
                let packet = try decoder.decode(RCONPacket.self, from: jsonData)
                if let block = socketReceiveBlocks[packet.Identifier] {
                    block(packet, nil)
                }
            } catch let error {
                print(error)
            }

        case .binary:
            break
        case .pong:
            break
        case .ping:
            break
        case .error(let error):
            if let _error = error { print(_error) }
            forceDisconnect()
            connect()
        case .viabilityChanged:
            break
        case .reconnectSuggested:
            break
        case .cancelled:
            break
        }
    }
}



// MARK: - Value Helper
extension RCONPacket {
    func decode<T: Decodable>(model: T.Type) throws -> T {
        let decoder = JSONDecoder()
        guard let data = Message.data(using: .utf8) else {
            throw SwiftSocKetError.DecodeError("Message is Null")
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error {
            throw SwiftSocKetError.DecodeError(error.localizedDescription)
        }
    }
    
    func getSingleValue() throws -> String {
        let components = Message.components(separatedBy: "\"")
        guard components.count == 3 else {
            throw SwiftSocKetError.DecodeError("Can't Parse Value > \(Message)")
        }
        return components[1]
    }
}
