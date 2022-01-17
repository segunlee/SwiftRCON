//
//  ChatProvider.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/13.
//

import Foundation
import UIKit


class ChatProvider: NSObject {
    var messages: [ChatMessageProtocol] = [ChatMessageProtocol]()
    weak var tableView: UITableView?
    
    func registerTableView(_ tableView: UITableView) {
        self.tableView = tableView
        tableView.register(UINib(nibName: "ChatBubbleOutgoingCell", bundle: nil), forCellReuseIdentifier: ChatBubbleOutgoingCell.identifier)
        tableView.register(UINib(nibName: "ChatBubbleIncomingCell", bundle: nil), forCellReuseIdentifier: ChatBubbleIncomingCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initial(messages: [ChatMessageProtocol]) {
        self.messages.removeAll()
        self.messages.append(contentsOf: messages)
        tableView?.reloadData()
        tableView?.scrollToBottom()
    }
    
    func clear() {
        messages.removeAll()
        tableView?.reloadData()
    }
    
    func insert(message: ChatMessageProtocol) {
        messages.append(message)
        guard let indexPath = tableView?.lastIndexPath else {
            tableView?.reloadData()
            return
        }
        
        tableView?.insertRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: .fade)
        tableView?.scrollToBottom(animated: true)
    }
}

extension ChatProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}

extension ChatProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.isIncoming {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleIncomingCell.identifier, for: indexPath) as! ChatBubbleIncomingCell
            cell.userImageView.image = UIImage(named: "RUSTCI")
            cell.userNameLabel.text = message.name
            cell.messageLabel.text = message.message
            cell.dateLabel.text = message.date.toString()
            
            switch message.channelType {
            case .Team:
                cell.messageBackgroundColorView.backgroundColor = UIColor(rgb: 0x835EEB)
                cell.messageLabel.textColor = .white
            default:
                cell.messageBackgroundColorView.backgroundColor = UIColor(rgb: 0xF0F0F0)
                cell.messageLabel.textColor = .darkGray
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleOutgoingCell.identifier, for: indexPath) as! ChatBubbleOutgoingCell
        cell.messageLabel.text = message.message
        cell.dateLabel.text = message.date.toString()
        return cell
    }
}
