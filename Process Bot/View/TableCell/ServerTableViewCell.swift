//
//  ServerTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 01/09/21.
//

import UIKit

class ServerTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMachineNameValue: UILabel!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblUserTypeValue: UILabel!
    @IBOutlet weak var lblRemarksValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        viewShadow.layer.cornerRadius = 5
        viewShadow.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    }
    
}
