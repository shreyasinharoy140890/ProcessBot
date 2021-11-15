//
//  AssignmentTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 15/11/21.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelroleName: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    
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

    

