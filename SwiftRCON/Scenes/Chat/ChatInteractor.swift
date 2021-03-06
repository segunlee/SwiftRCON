//
//  ChatInteractor.swift
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

protocol ChatBusinessLogic {
    func fetchChat(request: Chat.FetchChat.Request)
    func receiveChat(request: Chat.ReceiveChat.Request)
}

protocol ChatDataStore {
    
}

class ChatInteractor: ChatBusinessLogic, ChatDataStore {
    var presenter: ChatPresentationLogic?
    var worker: ChatWorker?
    
    
    // MARK: Do something
    func fetchChat(request: Chat.FetchChat.Request) {
        guard let activeSocket = activeSocket else { return }
        guard activeSocket.isConnected else { return }

        activeSocket.requestChatTail { [weak self] chats, error in
            if let error = error {
                print(error)
                return
            }
            
            self?.presenter?.presentFetchChat(response: .init(chats: chats))
        }
    }
    
    func receiveChat(request: Chat.ReceiveChat.Request) {
        guard let activeSocket = activeSocket else { return }
        guard activeSocket.isConnected else { return }
        
        activeSocket.requestChatRealtime { [weak self] chat, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let chat = chat else {
                return
            }
            
            self?.presenter?.presentReceiveChat(response: .init(message: chat))
        }
    }
}
