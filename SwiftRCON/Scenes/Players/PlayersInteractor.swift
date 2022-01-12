//
//  PlayersInteractor.swift
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

protocol PlayersBusinessLogic {
    func fetchPlayerList(request: Players.FetchPlayerList.Request)
}

protocol PlayersDataStore {
    //var name: String { get set }
}

class PlayersInteractor: PlayersBusinessLogic, PlayersDataStore {
    var presenter: PlayersPresentationLogic?
    
    // MARK: FETCH
    func fetchPlayerList(request: Players.FetchPlayerList.Request) {
        guard let activeSocket = activeSocket else { return }
        guard activeSocket.isConnected else { return }
        activeSocket.requestPlayerList(completion: { [weak self] players, error in
            self?.presenter?.presentFetchPlayerList(response: .init(players: players))
        })
    }
}
