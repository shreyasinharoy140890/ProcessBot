//
//  departmentTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 12/08/21.
//

import UIKit

class departmentTableViewCell: UITableViewCell {

    @IBOutlet weak var departmentImageView: UIImageView!
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
