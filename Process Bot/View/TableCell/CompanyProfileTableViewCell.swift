//
//  CompanyProfileTableViewCell.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/09/21.
//

import UIKit

class CompanyProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPostDetails: UILabel!
    @IBOutlet weak var lblPostName: UILabel!
    @IBOutlet weak var viewpostName: UIView!
    @IBOutlet weak var viewPost: UIView!
    var dictProfileDetails:ProfileListModel?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSetup(index:Int){
        
        if (index % 2 == 0) {
            viewPost.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
            viewpostName.backgroundColor = UIColor(named: "ScheduleColor") ?? UIColor(named: "ScheduleColor")
        }else {
            viewPost.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
            viewpostName.backgroundColor = UIColor(named: "customLightBlue") ?? UIColor(named: "customLightBlue")
           
        }
        
}
}
