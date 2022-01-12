//
//  InternalDataStore.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation


// TEMP
enum Server {
    struct ConnectInfo {
        var ip: String = ""
        var rconPort: String = ""
        var rconPassword: String = ""
        
        func makeURL() -> URL {
            let urlStr = "ws://\(ip):\(rconPort)/\(rconPassword)"
            return URL(string: urlStr)!
        }
    }
}


// TEMP
var currentConnectInfo = Server.ConnectInfo()
var activeSocket: SwiftSocket? = SwiftSocket(connectInfo: currentConnectInfo)
