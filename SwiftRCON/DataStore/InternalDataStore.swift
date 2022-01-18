//
//  InternalDataStore.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import Foundation


enum Server {
    struct ConnectInfo {
        var ip: String {
            (UserDefaults.standard.value(forKey: "_SIP") as? String) ?? ""
        }
        var rconPort: String {
            (UserDefaults.standard.value(forKey: "_SPT") as? String) ?? ""
        }
        var rconPassword: String {
            (UserDefaults.standard.value(forKey: "_PW") as? String) ?? ""
        }
        
        func makeURL() -> URL {
            let urlStr = "ws://\(ip):\(rconPort)/\(rconPassword)"
            return URL(string: urlStr)!
        }
        
        func validate() -> Bool {
            if !ip.isEmpty && !rconPort.isEmpty && !rconPassword.isEmpty {
                return true
            }
            return false
        }
    }
}

var connectInfo = Server.ConnectInfo()
var activeSocket: SwiftSocket?
