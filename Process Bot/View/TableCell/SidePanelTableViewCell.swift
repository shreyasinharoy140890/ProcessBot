//
//  SidePanelTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 15/07/21.
//

import UIKit

class SidePanelTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var imageMenu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
