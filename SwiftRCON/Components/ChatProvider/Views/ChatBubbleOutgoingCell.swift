//
//  ChatBubbleOutgoingCell.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/14.
//

import UIKit

class ChatBubbleOutgoingCell: UITableViewCell {
    static let identifier = "ChatBubbleOutgoingCell"

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBackgroundColorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBackgroundColorView.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner])
        messageBackgroundColorView.backgroundColor = UIColor(rgb: 0x568FFE)
        messageLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
