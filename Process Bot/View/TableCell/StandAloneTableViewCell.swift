//
//  StandAloneTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 25/08/21.
//

import UIKit

class StandAloneTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMachineNameValue: UILabel!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblUserTypeValue: UILabel!
    @IBOutlet weak var lblRemarksValue: UILabel!
    @IBOutlet weak var btnkeys: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewShadow.layer.cornerRadius = 5
        viewShadow.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
