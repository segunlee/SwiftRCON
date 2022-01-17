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
import KeyboardLayoutGuide


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
        setupTableView()
        setupInputView()
        handleNotifications()
        interactor?.fetchChat(request: .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: Noticication
    func handleNotifications() {
        NotificationCenter.default.addObserver(forName: .SocketDidConnect, object: nil, queue: .main) { [weak self] _ in
            self?.chatProvier.clear()
            self?.interactor?.fetchChat(request: .init())
        }
        NotificationCenter.default.addObserver(forName: .SocketDidDisconnect, object: nil, queue: .main) { _ in

        }
    }
    
    // MARK: INPUT
    @IBOutlet weak var inputContainerView: UIView!
    private var  messageInputView = MessageInputView()
    func setupInputView() {
        inputContainerView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
        inputContainerView.addSubview(messageInputView)
        
        messageInputView.translatesAutoresizingMaskIntoConstraints = false
        messageInputView.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        messageInputView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor).isActive = true
        messageInputView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor).isActive = true
        messageInputView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor).isActive = true
        messageInputView.addTarget(self, action: #selector(inputViewPrimaryActionTriggered(inputView:)), for: .primaryActionTriggered)
    }
    
    @objc func inputViewPrimaryActionTriggered(inputView: MessageInputView) {
        activeSocket?.send(input: "say \(inputView.message)")
    }
    
    // MARK: CHAT
    @IBOutlet weak var tableView: UITableView!
    private var chatProvier = ChatProvider()

    func setupTableView() {
        chatProvier.registerTableView(tableView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func displayFetchChat(viewModel: Chat.FetchChat.ViewModel) {
        chatProvier.initial(messages: viewModel.chats)
        interactor?.receiveChat(request: .init())
    }
    
    func displayReceiveChat(viewModel: Chat.ReceiveChat.ViewModel) {
        chatProvier.insert(message: viewModel.message)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        tableView.scrollToBottom()
    }
}
