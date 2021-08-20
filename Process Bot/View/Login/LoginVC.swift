//
//  LoginVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 14/07/21.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate,AlertDisplayer{

    @IBOutlet weak var testEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegistration: UIButton!
    var viewmodelLogin:loginViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testEmail.delegate = self
        textPassword.delegate = self
        setupUI()
        testEmail.tag = 0
        textPassword.tag = 1
        testEmail.addTarget(self, action: #selector(getTextInput(_:)), for: .editingChanged)
        //placeholder text color - (Shreya-20.8.21)
        testEmail.attributedPlaceholder = NSAttributedString(string: "Email",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textPassword.addTarget(self, action: #selector(getTextInput(_:)), for: .editingChanged)
        //placeholder text color - (Shreya-20.8.21)
        textPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        viewmodelLogin = LoginViewModel()
        viewmodelLogin?.manager = RequestManager()
        callGetToken()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        viewEmail.layer.cornerRadius = 5
        viewPassword.layer.cornerRadius = 5
        btnLogin.layer.cornerRadius = 5
        //Add Corner Radius to Registration Button - (Shreya - 20.8.2021)
        btnRegistration.layer.cornerRadius = 5
        viewEmail.addShadow(offset: CGSize.init(width: 0, height: 2), color: .gray, radius: 3, opacity: 0.6)
        viewPassword.addShadow(offset: CGSize.init(width: 0, height: 2), color: .gray, radius: 3, opacity: 0.6)
    }

    @IBAction func btnLogin(_ sender: Any) {
        callLoginApi()
//        let robotVC = RobotVC(nibName: "RobotVC", bundle: nil)
//        self.navigationController?.pushViewController(robotVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func getTextInput(_ sender:UITextField ){
        viewmodelLogin?.arrayValueContainer[sender.tag] = sender.text!
        print(viewmodelLogin?.arrayValueContainer as Any)
    }

}
// MARK:- Api Call
extension LoginVC {
    func callLoginApi(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewmodelLogin?.callLoginApi(strEmail: viewmodelLogin?.arrayValueContainer[0] , strPassword: viewmodelLogin?.arrayValueContainer[1], completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    let robotVC = RobotVC(nibName: "RobotVC", bundle: nil)
                    self.navigationController?.pushViewController(robotVC, animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
    func callGetToken(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewmodelLogin?.getToken( completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                   
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
}

