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
    
    func registerTableView(_ tableView: UITableView) {
        tableView.register(UINib(nibName: "ChatBubbleCell", bundle: nil), forCellReuseIdentifier: ChatBubbleCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initial(messages: [ChatMessageProtocol]) {
        self.messages.removeAll()
        self.messages.append(contentsOf: messages)
    }
    
    func insert(message: ChatMessageProtocol) {
        messages.append(message)
        // TODO: s
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleCell.identifier, for: indexPath) as? ChatBubbleCell else { return UITableViewCell() }
        cell.bind(to: messages[indexPath.row])
        return cell
    }
}
