//
//  DirectoryTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 10/11/21.
//

import UIKit

class DirectoryTableViewCell: UITableViewCell {

    @IBOutlet weak var labeldirectoryname: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var labeldescription: UILabel!
    @IBOutlet weak var viewDirectory: UIView!
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
