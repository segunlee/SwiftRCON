//
//  ChatBubbleIncomingCell.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/14.
//

import UIKit

class ChatBubbleIncomingCell: UITableViewCell {
    static let identifier = "ChatBubbleIncomingCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBackgroundColorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.cornerRadius = userImageView.bounds.width / 2
        messageBackgroundColorView.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
