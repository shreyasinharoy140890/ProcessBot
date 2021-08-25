//
//  MachineHostVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 24/08/21.
//

import UIKit

class MachineHostVC: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
   // MARK: Customization of views
    func setupUI(){
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5, opacity: 0.4)
        mainView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 3.0, opacity: 0.4)
    }
   
    //MARK:- Button actions
    @IBAction func btnShowMenu(_ sender: UIButton) {
        if sender.isSelected {
            SidePanelViewController.default.hide()
            sender.isSelected = false
        }
        else {
            SidePanelViewController.default.show(on: self)
            sender.isSelected = true
        }
    }
}
