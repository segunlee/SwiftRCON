//
//  ChatMessageProtocol.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/13.
//

import UIKit

enum ChatChannelType: Int {
    case Global = 0
    case Team = 1
    case Server = 2
}

protocol ChatMessageProtocol {
    var name: String { get }
    var message: String { get }
    var date: Date { get }
    var isIncoming: Bool { get }
    var steamID: String { get }
    var channelType: ChatChannelType { get }
}
