//
//  SwiftSocket.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation
import Starscream
import UIKit

typealias SocketReceiveBlock = (RCONPacket?, Error?) -> Void

struct RCONPacket: Codable {
    var Identifier: Int
    var Message: String
    var `Type`: String
}

enum SwiftSocKetError: Error {
    case SocketError(String)
    case DecodeError(String)
}

extension Notification.Name {
    static let SocketDidConnect = Notification.Name("SocketDidConnect")
    static let SocketDidDisconnect = Notification.Name("SocketDidDisconnect")
}

class SwiftSocket {
    var socket: WebSocket
    var socketReceiveBlocks = [Int: SocketReceiveBlock]()
    var isConnected = false {
        didSet {
            print("Server Connection: \(isConnected)")
            NotificationCenter.default.post(name: isConnected ? .SocketDidConnect : .SocketDidDisconnect, object: nil)
        }
    }

    
    // MARK: -
    init(url: URL) {
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
        self.socket.callbackQueue = DispatchQueue(label: "SGIOS.starscream.SwiftRCON")
    }
    
    init(connectInfo: Server.ConnectInfo) {
        var request = URLRequest(url: connectInfo.makeURL())
        request.timeoutInterval = 5
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
    }
    
    
    // MARK: -
    func connect() {
        guard !isConnected else { return }
        print("Start Connect...")
        socket.connect()
    }
    
    func disconnect() {
        guard isConnected else { return }
        print("Start Disconnect...")
        socket.disconnect()
    }
    
    func forceDisconnect() {
        print("Start Force Disconnect...")
        isConnected = false
        socket.forceDisconnect()
    }
}
