//
//  ChatPresenter.swift
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

protocol ChatPresentationLogic {
    func presentFetchChat(response: Chat.FetchChat.Response)
    func presentReceiveChat(response: Chat.ReceiveChat.Response)
}

class ChatPresenter: ChatPresentationLogic {
    weak var viewController: ChatDisplayLogic?
    
    // MARK: Do something
    
    func presentFetchChat(response: Chat.FetchChat.Response) {
        DispatchQueue.main.async {
            self.viewController?.displayFetchChat(viewModel: .init(chats: response.chats))
        }
    }
    
    func presentReceiveChat(response: Chat.ReceiveChat.Response) {
        DispatchQueue.main.async {
            self.viewController?.displayReceiveChat(viewModel: .init(message: response.message))
        }
    }
}
