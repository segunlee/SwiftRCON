//
//  PlayersCell.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import UIKit

class PlayersCell: UITableViewCell {
    
    @IBOutlet weak var playerIcon: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var connectedTime: UILabel!
    @IBOutlet weak var ping: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
