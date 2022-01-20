//
//  CompanyProfileVC.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 15/09/21.
//

import UIKit

class CompanyProfileVC: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var containerView    : UIView!
    @IBOutlet weak var buttonpersonalinfo: UIButton!
    @IBOutlet weak var buttonlicenceinfo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buttonpersonalinfo.backgroundColor = UIColor.lightGray
        buttonlicenceinfo.backgroundColor = UIColor.white
      //  remove(asChildViewController: LicenceInfoViewController)
        add(asChildViewController: PersonalInfoViewController)
  
    }
    func setupUI (){
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 3.0, opacity: 0.6)
        
    }
    private lazy var PersonalInfoViewController: PersonalInfoVC = {
        // Load Storyboard
        let VC = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: nil)
        // Add View Controller as Child View Controller
        self.add(asChildViewController: VC)
        
        return VC
    }()
    
    private lazy var LicenceInfoViewController: LicenceInfo = {
        // Load Storyboard
        let VC = LicenceInfo(nibName: "LicenceInfo", bundle: nil)
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: VC)
        
        return VC
    }()
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    //----------------------------------------------------------------
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    private func updateView() {
        if buttonpersonalinfo.isTouchInside == true {
            buttonpersonalinfo.backgroundColor = UIColor.lightGray
            buttonlicenceinfo.backgroundColor = UIColor.white
            remove(asChildViewController: LicenceInfoViewController)
            add(asChildViewController: PersonalInfoViewController)
        } else {
            buttonlicenceinfo.backgroundColor = UIColor.lightGray
            buttonpersonalinfo.backgroundColor = UIColor.white
            remove(asChildViewController: PersonalInfoViewController)
            add(asChildViewController: LicenceInfoViewController)
        }
    }
    
    //----------------------------------------------------------------
    
    func setupView() {

        updateView()
    }
    
    
    
    //MARK:- Button Actions
       @IBAction func btnMenuAction(_ sender: UIButton) {
           if sender.isSelected {
               SidePanelViewController.default.hide()
               sender.isSelected = false
           }
           else {
               SidePanelViewController.default.show(on: self)
               sender.isSelected = true
           }
       }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnpersonalinfo(_ sender: Any) {
       updateView()
    }
    @IBAction func btnlicenceinfo(_ sender: Any) {
       updateView()
    }
    
   

}
