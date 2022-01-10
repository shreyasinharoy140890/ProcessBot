//
//  LoginViewModel.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 02/08/21.
//

import Foundation


protocol loginViewModelProtocol : class {
    var arrayValueContainer:[String]{get set}
    var manager: RequestManager? {get set}
    func callLoginApi(strEmail:String?,strPassword:String?, completion:@escaping (ProcessBot<Any?>)-> Void)
    func getToken( completion:@escaping (ProcessBot<Any?>)-> Void)
    func getLoginToken( completion:@escaping (ProcessBot<Any?>)-> Void)
}
class LoginViewModel:loginViewModelProtocol {
   
    var arrayValueContainer = ["",""]
    var manager: RequestManager?
    var tokenModel:TokenModel?
    var userModel:[LoginModels] = []
   
    
    func getToken( completion:@escaping (ProcessBot<Any?>)-> Void){
        
        let dictParams:[String:Any] = ["Appsecret": "C7B4C644-604B-4ADF-8B0E-1D23D13B8EC7",
            "AppName": "IntelgicApp"]
        print(dictParams)
        self.manager?.request(.getToken, method: .post, parameters: dictParams, encoding: .json, headers: nil, handler: { (result) in
            
            switch result {
            
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    print(dictResponse)
                    do {
                        
                        self.tokenModel = try JSONDecoder().decode(TokenModel.self, from: dictResponse as! Data)
                        if let token = self.tokenModel?.token {
                            UserDefaults.standard.set(token, forKey: "TOKEN")
                        }

                        completion(.success(true))
                    }
                    catch _ {
                        completion(.failure(ProcessBotNetWorkrror.noData))
                    }
                    
                    
                }
                else {
                    completion(.failure(ProcessBotNetWorkrror.noData))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
        
    }
    
    func callLoginApi(strEmail:String?,strPassword:String?, completion:@escaping (ProcessBot<Any?>)-> Void){
        guard let email = strEmail, email.trimmed.count > 0 else {
            completion(.failure(ProcessBotError.customMessage("please enter your email address")))
            return
        }
        guard email.isValidEmail() else {
            completion(.failure(ProcessBotError.customMessage("please enter your proper email address")))
            return
        }
        guard let password = strPassword , password.trimmed.count > 0 else {
            completion(.failure(ProcessBotError.customMessage("please enter your Password")))
            return
        }
        
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
            completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
            return
        }
        let dictParams:[String:Any] = ["Username": email,
                                       "Password": password]
        print(dictParams)
        
        let headers : HTTPHeaders = [
            "Token": "\(token)",
            "AppName":"IntelgicApp"
        ]
        self.manager?.request(.login, method: .post, parameters: dictParams, encoding: .json, headers: headers, handler:   { (result) in
            
            switch result {
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    //print(dictResponse)
                    do{
                        let loginmodel = try JSONDecoder().decode([LoginModels].self, from: dictResponse as! Data)
                        self.userModel = loginmodel
                        print(self.userModel[0].appName!)
                        UserDefaults.standard.set(self.userModel[0].clientID!, forKey: "CLIENTID")
                        UserDefaults.standard.set(self.userModel[0].userID!, forKey: "USERID")
                        UserDefaults.standard.set(self.userModel[0].appSecret!, forKey: "APPSECRET")
                        UserDefaults.standard.set(self.userModel[0].email!, forKey: "EMAIL")
                        UserDefaults.standard.set(self.userModel[0].fullName!, forKey: "FULLNAME")
                        UserDefaults.standard.set(self.userModel[0].appName!,forKey:"APPNAME")
                        completion(.success(true))
                    }
                    catch _ {
                        completion(.failure(ProcessBotNetWorkrror.noData))
                    }
                    
                }
                else {
                    completion(.failure(ProcessBotNetWorkrror.noData))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
        
    }
    
    func getLoginToken(completion: @escaping (ProcessBot<Any?>) -> Void) {
        let appname  = UserDefaults.standard.value(forKey: "APPNAME")
        let appsecret = UserDefaults.standard.value(forKey: "APPSECRET")
        let dictParams:[String:Any] = ["Appsecret": appsecret,
            "AppName": appname]
        print(dictParams)
        self.manager?.request(.getToken, method: .post, parameters: dictParams, encoding: .json, headers: nil, handler: { (result) in
            
            switch result {
            
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    print(dictResponse)
                    do {
                        
                        self.tokenModel = try JSONDecoder().decode(TokenModel.self, from: dictResponse as! Data)
                        if let logintoken = self.tokenModel?.token {
                            UserDefaults.standard.set(logintoken, forKey: "LOGINTOKEN")
                        }

                        completion(.success(true))
                    }
                    catch _ {
                        completion(.failure(ProcessBotNetWorkrror.noData))
                    }
                    
                    
                }
                else {
                    completion(.failure(ProcessBotNetWorkrror.noData))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    
}
