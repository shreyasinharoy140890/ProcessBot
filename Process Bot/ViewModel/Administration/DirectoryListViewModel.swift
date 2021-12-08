//
//  DirectoryListViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 09/11/21.
//

import Foundation
protocol DirectoryViewModelProtocol : class {
    func getDirectoryList(completion:@escaping (ProcessBot<Any?>) -> Void)
    func getCurrentDirectory(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var directorylist:[DirectoryModel]!{get}
    var currentdirectory:[CurrentDirectoryModel]!{get}
   
}
class DirectoryViewModel:DirectoryViewModelProtocol
{
  
    
    func getCurrentDirectory(completion: @escaping (ProcessBot<Any?>) -> Void) {
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

        self.manager?.request(.customGetURL(with: .getWorkingDirectory, components: ["ClientID":clientId,"UserID":userId]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([CurrentDirectoryModel].self, from: dictResponse as! Data)
                         self.currentdirectory = directorymodel

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
   
    
    func getDirectoryList(completion: @escaping (ProcessBot<Any?>) -> Void) {
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

        self.manager?.request(.customGetURL(with: .directorylist, components: ["ClientID":clientId,"DirectoryID":0]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([DirectoryModel].self, from: dictResponse as! Data)
                         self.directorylist = directorymodel

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
    
    var manager: RequestManager?
    
    var directorylist: [DirectoryModel]!
    var currentdirectory: [CurrentDirectoryModel]!
    
}
