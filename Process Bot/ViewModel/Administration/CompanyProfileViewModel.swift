//
//  CompanyProfileViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/09/21.
//

import Foundation
protocol CompanyProfileViewModelProtocol : class {
    func getProfileList(completion:@escaping (ProcessBot<Any?>) -> Void)
    func getlicencedetails(completion:@escaping (ProcessBot<Any?>) -> Void)
    func gettimezonelist(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var profilelist:[ProfileListModel]{get}
    var licencelist:[LicenceListModel]{get}
    var timezonelist:[TimeZoneModel]{get}
}
class CompanyProfileViewModel:CompanyProfileViewModelProtocol
{
    func gettimezonelist(completion: @escaping (ProcessBot<Any?>) -> Void) {
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
        let headers : HTTPHeaders = [
            "Token": "\(token)",
            "AppName":"IntelgicApp"
        ]
        self.manager?.request(.customGetURL(with: .timezonelist, components:["":""]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([TimeZoneModel].self, from: dictResponse as! Data)
                         self.timezonelist = directorymodel

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

    var timezonelist: [TimeZoneModel] = []
    
    var licencelist: [LicenceListModel] = []
    
    func getlicencedetails(completion: @escaping (ProcessBot<Any?>) -> Void) {
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

        self.manager?.request(.customGetURL(with: .licencedetails, components: ["ClientId":clientId]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([LicenceListModel].self, from: dictResponse as! Data)
                         self.licencelist = directorymodel
//                        let customerID =  UserDefaults.standard.set(self.licencelist.custID!, forKey: "USER_ID")
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
    
    
    
    func getProfileList(completion: @escaping (ProcessBot<Any?>) -> Void) {
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
         guard let customerid  = UserDefaults.standard.value(forKey: "CUSTOMERID") else {
              completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
              return
          }
       
        // let dictParams:[String:Any] = ["ClientID": clientId]
         let headers : HTTPHeaders = [
             "Token": "\(token)",
             "AppName":"IntelgicApp"
         ]

        self.manager?.request(.customGetURL(with: .profilelistdetails, components: ["CustFlag":"Y","CustID":customerid]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([ProfileListModel].self, from: dictResponse as! Data)
                         self.profilelist = directorymodel
                        print(self.profilelist)
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
    
    var profilelist: [ProfileListModel] = []
    
}
