//
//  ChatViewController.swift
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


protocol ChatDisplayLogic: AnyObject {
    func displayFetchChat(viewModel: Chat.FetchChat.ViewModel)
    func displayReceiveChat(viewModel: Chat.ReceiveChat.ViewModel)
}

class ChatViewController: UIViewController, ChatDisplayLogic {
    var interactor: ChatBusinessLogic?
    var router: (NSObjectProtocol & ChatRoutingLogic & ChatDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ChatInteractor()
        let presenter = ChatPresenter()
        let router = ChatRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        handleNotifications()
        interactor?.fetchChat(request: .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: Noticication
    func handleNotifications() {
        NotificationCenter.default.addObserver(forName: .SocketDidConnect, object: nil, queue: .main) { [weak self] _ in
            self?.messages.removeAll()
            self?.interactor?.fetchChat(request: .init())
        }
        NotificationCenter.default.addObserver(forName: .SocketDidDisconnect, object: nil, queue: .main) { [weak self] _ in
            self?.messages.removeAll()
        }
    }
    
    
    // MARK: CHAT
    var messages = [[ChatMessage]]()
    
    func displayFetchChat(viewModel: Chat.FetchChat.ViewModel) {
        messages.removeAll()
        
        // TODO:..
        interactor?.receiveChat(request: .init())
    }
    
    func displayReceiveChat(viewModel: Chat.ReceiveChat.ViewModel) {
        // TODO:..
    }
}
