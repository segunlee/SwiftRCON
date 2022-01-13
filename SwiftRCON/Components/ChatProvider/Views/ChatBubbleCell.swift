//
//  ChatBubbleCell.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/13.
//

import UIKit

class ChatBubbleCell: UITableViewCell {
    static let identifier = "ChatBubbleCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var trailingConstraint: NSLayoutConstraint!
    
    var isIncoming: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leadingConstraint.isActive = isIncoming
        trailingConstraint.isActive = !isIncoming
        nameLabel.textAlignment = isIncoming ? .left : .right
    }
    
    func bind(to message: ChatMessageProtocol) {
        nameLabel.text = message.name
        messageLabel.text = message.message
        dateLabel.text = message.date.toString()
        isIncoming = message.isIncoming
    }
}
