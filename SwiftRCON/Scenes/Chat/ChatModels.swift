//
//  ChatModels.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/11.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


enum Chat {
    // MARK: Use cases
    
    enum FetchChat {
        struct Request { }
        struct Response {
            var chats: [ChatMessage]
        }
        struct ViewModel {
            var chats: [ChatMessage]
        }
    }
    
    enum ReceiveChat {
        struct Request { }
        struct Response {
            var message: ChatMessage
        }
        struct ViewModel {
            var message: ChatMessage
        }
    }
}


typealias ChatMessage = RustChat
extension ChatMessage: ChatMessageProtocol {
    var name: String {
        return username
    }
    
    var date: Date {
        return Date(timeIntervalSince1970: Double(time))
    }
    
    var isIncoming: Bool {
        return username != "SERVER"
    }
    
    var steamID: String {
        return userId
    }
}
