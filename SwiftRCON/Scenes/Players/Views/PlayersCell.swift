//
//  PlayersCell.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/10.
//

import UIKit

class PlayersCell: UITableViewCell {
    static let identifier = "PCELL"
    @IBOutlet weak var playerIcon: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var connectedTime: UILabel!
    @IBOutlet weak var ping: UILabel!
    
    private var player: RustPlayer?
    private var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerIcon.cornerRadius = playerIcon.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
    }

    
    func bind(player: RustPlayer) {
        self.player = player
        playerIcon.image = UIImage(named: "RUSTCI")
        playerName.text = player.displayName
        ping.text = "Ping: \(player.ping)"
        updateConntedTime()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.player?.connectedSeconds += 1
            self?.updateConntedTime()
        })
    }
    
    private func updateConntedTime() {
        connectedTime.text = "Connected: " + (player?.connectedTime ?? "unknown")
    }
}
