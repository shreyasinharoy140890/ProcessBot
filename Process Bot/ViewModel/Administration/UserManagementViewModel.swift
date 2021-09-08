//
//  UserManagementViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 07/09/21.
//

import Foundation
protocol UserManagementViewModelProtocol : class {
    func getUsersList(completion:@escaping (ProcessBot<Any?>) -> Void)
    func getRolesList(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var usersdetails:[UserListModel]{get}
    var roleslist:[RoleListModel]{get}
}
class UserManagementViewModel:UserManagementViewModelProtocol {
    var roleslist: [RoleListModel] = []
   var usersdetails: [UserListModel] = []
   var manager: RequestManager?

    func getRolesList(completion: @escaping (ProcessBot<Any?>) -> Void) {
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
         guard let clientId  = UserDefaults.standard.value(forKey: "CLIENTID") else {
              completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
              return
          }
      
        
        // let dictParams:[String:Any] = ["ClientID": clientId]
         let headers : HTTPHeaders = [
             "Token": "\(token)",
             "AppName":"IntelgicApp"
         ]

        self.manager?.request(.customGetURL(with: .roleslistdetails, components: ["ClientID":clientId,"RoleID":"0"]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([RoleListModel].self, from: dictResponse as! Data)
                         self.roleslist = directorymodel

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
    
   
    func getUsersList(completion: @escaping (ProcessBot<Any?>) -> Void) {
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
         guard let clientId  = UserDefaults.standard.value(forKey: "CLIENTID") else {
              completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
              return
          }
        guard let userId  = UserDefaults.standard.value(forKey: "USERID") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
        
        
        // let dictParams:[String:Any] = ["ClientID": clientId]
         let headers : HTTPHeaders = [
             "Token": "\(token)",
             "AppName":"IntelgicApp"
         ]
          
         
         
        self.manager?.request(.customGetURL(with: .userslistdetails, components: ["ClientID":clientId,"UserID":userId]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([UserListModel].self, from: dictResponse as! Data)
                         self.usersdetails = directorymodel

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
    
    