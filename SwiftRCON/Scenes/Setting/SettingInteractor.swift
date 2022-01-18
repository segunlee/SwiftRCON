//
//  SettingInteractor.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/18.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SettingBusinessLogic {
    func doSomething(request: Setting.Something.Request)
    func saveServerInfo(request: Setting.SaveServer.Request)
}

protocol SettingDataStore {
    //var name: String { get set }
}

class SettingInteractor: SettingBusinessLogic, SettingDataStore {
    var presenter: SettingPresentationLogic?
    var worker: SettingWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Setting.Something.Request) {
        worker = SettingWorker()
        worker?.doSomeWork()
        
        let response = Setting.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func saveServerInfo(request: Setting.SaveServer.Request) {
        UserDefaults.standard.set(request.ip, forKey: "_SIP")
        UserDefaults.standard.set(request.port, forKey: "_SPT")
        UserDefaults.standard.set(request.password, forKey: "_PW")
        UserDefaults.standard.synchronize()
        
        activeSocket?.forceDisconnect()
        activeSocket = nil
        
        activeSocket = SwiftSocket(connectInfo: connectInfo)
        
        NotificationCenter.default.removeObserver(self, name: .SocketDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(socketDidConnect(_:)), name: .SocketDidConnect, object: nil)
        activeSocket?.connect()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 5) {
            DispatchQueue.main.async {
                NotificationCenter.default.removeObserver(self, name: .SocketDidConnect, object: nil)
                guard let activeSocket = activeSocket  else { return }
                guard !activeSocket.isConnected else { return }
                AlertProvider.message(title: "Alert", message: "Connection Failure")
            }
        }
    }
    
    // MARK: - Private
    @objc func socketDidConnect(_ sender: Any) {
        NotificationCenter.default.removeObserver(self, name: .SocketDidConnect, object: nil)
        AlertProvider.message(title: "Alert", message: "Connection Success")
    }
}