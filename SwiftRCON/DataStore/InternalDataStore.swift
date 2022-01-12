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
        // TEMPTEMP
        var ip: String = (UserDefaults.standard.value(forKey: "_SIP") as? String) ?? ""
        var rconPort: String = (UserDefaults.standard.value(forKey: "_SPT") as? String) ?? ""
        var rconPassword: String = (UserDefaults.standard.value(forKey: "_PW") as? String) ?? ""
        
        func makeURL() -> URL {
            let urlStr = "ws://\(ip):\(rconPort)/\(rconPassword)"
            return URL(string: urlStr)!
        }
    }
}


// TEMP
var currentConnectInfo = Server.ConnectInfo()
var activeSocket: SwiftSocket? = SwiftSocket(connectInfo: currentConnectInfo)
