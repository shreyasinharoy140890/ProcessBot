//
//  UserManagementTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 06/09/21.
//

import UIKit

class UserManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var labelusername: UILabel!
    @IBOutlet weak var labeluseremail: UILabel!
    @IBOutlet weak var labelrolename: UILabel!
    @IBOutlet weak var labelfullname: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var labeldate: UILabel!
    
    @IBOutlet weak var labeltime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDetails.isHidden = true
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
    

