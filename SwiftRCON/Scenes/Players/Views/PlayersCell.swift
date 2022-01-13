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
    
    private var player: RustPlayer?
    private var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
    }

    
    func bind(player: RustPlayer) {
        self.player = player
        playerName.text = player.displayName
        connectedTime.text = player.connectedTime
        ping.text = "Ping: \(player.ping)"
        
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.player?.connectedSeconds += 1
            if let time = self?.player?.connectedTime {
                self?.connectedTime.text = time
            }
        })
    }
}
