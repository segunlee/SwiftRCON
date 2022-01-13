//
//  ChatMessageProtocol.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/13.
//

import UIKit

protocol ChatMessageProtocol {
    var name: String { get }
    var message: String { get }
    var date: Date { get }
    var isIncoming: Bool { get }
    var steamID: String { get }
}
