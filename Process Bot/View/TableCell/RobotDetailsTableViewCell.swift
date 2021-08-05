//
//  RobotDetailsTableViewCell.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 26/07/21.
//

import UIKit

class RobotDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPostDetails: UILabel!
    @IBOutlet weak var lblPostName: UILabel!
    @IBOutlet weak var viewpostName: UIView!
    @IBOutlet weak var viewPost: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
