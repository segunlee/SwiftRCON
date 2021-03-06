//
//  ConsoleInteractor.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ConsoleBusinessLogic {
    func fetchLogs(requst: Console.FetchLog.Request)
    func realtimeLog(request: Console.FetchLog.Request)
}

protocol ConsoleDataStore {
    
}

class ConsoleInteractor: ConsoleBusinessLogic, ConsoleDataStore {
    var presenter: ConsolePresentationLogic?
    var worker: ConsoleWorker?
    
    func fetchLogs(requst: Console.FetchLog.Request) {
        guard let activeSocket = activeSocket else { return }
        guard activeSocket.isConnected else { return }
        activeSocket.requestConsoleTail { [weak self] logs, error in
            if let error = error {
                print(error)
                return
            }
            
            self?.presenter?.presentFetchLogs(response: .init(logs: logs))
        }
    }
    
    func realtimeLog(request: Console.FetchLog.Request) {
        guard let activeSocket = activeSocket else { return }
        guard activeSocket.isConnected else { return }
        activeSocket.requestConsoleRealtimeLog { [weak self] log, error in
            DispatchQueue.main.async {
                guard let log = log else { return }
                self?.presenter?.presentRealtimeLogs(response: .init(logs: [log]))
            }
        }
    }
}
