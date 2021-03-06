//
//  PlayersModels.swift
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

enum Players {
    // MARK: Use cases
    
    enum Something {
        struct Request {
        }
        
        struct Response {
        }
        
        struct ViewModel{
        }
    }
    
    enum FetchPlayerList {
        struct Request {
            var connectInfo: Server.ConnectInfo
        }
        struct Response {
            var players: [RustPlayer]
        }
        struct ViewModel {
            var players: [RustPlayer]
        }
    }
    
}
