//
//  SwiftSocket+Rust.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation

enum RustCommand: String {
    case Status = "status"
    case ServerInfo = "serverinfo"
    case PlayerList = "global.playerlist"
    case ConsoleTail = "console.tail 100"
    case ChatTail = "chat.tail 500"
    
    var identifier: Int {
        switch self {
        case .Status: return 101
        case .PlayerList: return 102
        case .ServerInfo: return 103
        case .ConsoleTail: return 104
        case .ChatTail: return 105
        }
    }
}

protocol RustProtocol {
    func requestServerStatus(completion: @escaping (String?, Error?) -> Void)
    func requestServerInfo(completion: @escaping (RustServerInfo?, Error?) -> Void)
    func requestPlayerList(completion: @escaping ([RustPlayer], Error?) -> Void)
    func requestConsoleTail(completion: @escaping ([RustConsole], Error?) -> Void)
    func requestChatTail(completion: @escaping ([RustChat], Error?) -> Void)
}

extension Notification.Name {
    static let RustConsoleUpdated = Notification.Name("RustConsoleUpdated")
}


extension SwiftSocket: RustProtocol {
    func requestServerStatus(completion: @escaping (String?, Error?) -> Void) {
        send(rustCommand: .Status) { packet, error in
            if let error = error {
                completion(nil, SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                completion(nil, SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            do {
                let value = try packet.getSingleValue()
                completion(value, nil)
            } catch let error {
                completion(nil, error)
            }
            
        }
    }
    
    func requestServerInfo(completion: @escaping (RustServerInfo?, Error?) -> Void) {
        send(rustCommand: .ServerInfo) { packet, error in
            if let error = error {
                completion(nil, SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                completion(nil, SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            do {
                let model = try packet.decode(model: RustServerInfo.self)
                completion(model, nil)
            } catch let error {
                completion(nil, error)
            }
            
        }
    }
    
    func requestPlayerList(completion: @escaping ([RustPlayer], Error?) -> Void) {
        send(rustCommand: .PlayerList) { packet, error in
            if let error = error {
                completion([], SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                completion([], SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            do {
                let model = try packet.decode(model: [RustPlayer].self)
                completion(model, nil)
            } catch let error {
                completion([], error)
            }
            
        }
    }
    
    func requestConsoleTail(completion: @escaping ([RustConsole], Error?) -> Void) {
        send(rustCommand: .ConsoleTail) { packet, error in
            if let error = error {
                completion([], SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                completion([], SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            do {
                let model = try packet.decode(model: [RustConsole].self)
                completion(model, nil)
            } catch let error {
                completion([], error)
            }
            
        }
    }
    
    func requestConsoleRealtimeLog(polling: @escaping (RustConsole?, Error?) -> Void) {
        socketReceiveBlocks[0] = nil
        socketReceiveBlocks[0] = { (packet, error) in
            
            if let error = error {
                polling(nil, SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                polling(nil, SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            guard !packet.Message.isEmpty else {
                return
            }
            
            let model = RustConsole(packet: packet)
            polling(model, nil)
        }
    }
    
    func requestChatTail(completion: @escaping ([RustChat], Error?) -> Void) {
        send(rustCommand: .ChatTail) { packet, error in
            if let error = error {
                completion([], SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                completion([], SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            do {
                let model = try packet.decode(model: [RustChat].self)
                completion(model, nil)
            } catch let error {
                completion([], error)
            }
        }
    }
    
    func requestChatRealtime(polling: @escaping (RustChat?, Error?) -> Void) {
        socketReceiveBlocks[-1] = nil
        socketReceiveBlocks[-1] = { (packet, error) in
            
            if let error = error {
                polling(nil, SwiftSocKetError.SocketError(error.localizedDescription))
                return
            }
            
            guard let packet = packet else {
                polling(nil, SwiftSocKetError.DecodeError("Failed Decode Socket Packet"))
                return
            }
            
            guard !packet.Message.isEmpty else {
                return
            }
            
            do {
                let model = try packet.decode(model: RustChat.self)
                polling(model, nil)
            } catch let error {
                polling(nil, error)
            }
        }
    }
    
}
