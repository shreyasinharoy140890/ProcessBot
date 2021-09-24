//
//  RoleManagementTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 24/09/21.
//

import UIKit

class RoleManagementTableViewCell: UITableViewCell {
    @IBOutlet weak var labelrolename: UILabel!
    @IBOutlet weak var labelroledescription: UILabel!
    @IBOutlet weak var labelusercount: UILabel!
    @IBOutlet weak var labelusername: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var labeldate: UILabel!
    @IBOutlet weak var labeltime: UILabel!
    @IBOutlet weak var btnroleupdate: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var isDetailViewHidden: Bool {
        return viewDetails.isHidden
    }
    
    func showDetailView() {
        viewDetails.isHidden = false
    }

    func hideDetailView() {
        viewDetails.isHidden = true
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
    
}
