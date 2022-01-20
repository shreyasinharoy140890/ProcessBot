//
//  ActivityViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 19/08/21.
//

import Foundation
protocol ActivityViewModelProtocol : class {
    func getActivityDetails(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var activityarray:[ActivityDataModel]{get}
}
class ActivityViewModel:ActivityViewModelProtocol {
    var days:String?
    func getActivityDetails(completion: @escaping (ProcessBot<Any?>) -> Void) {
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
         guard let clientId  = UserDefaults.standard.value(forKey: "CLIENTID") else {
              completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
              return
          }
//         guard let userid  = UserDefaults.standard.value(forKey: "USERID") else {
//              completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
//              return
//          }
        // let dictParams:[String:Any] = ["ClientID": clientId]
         let headers : HTTPHeaders = [
             "Token": "\(token)",
             "AppName":"IntelgicApp"
         ]
          
        if  UserDefaults.standard.value(forKey: "DAYS") != nil
        {
            days = UserDefaults.standard.value(forKey: "DAYS") as? String
        }
        else
        {
           days = "30"
        }
         
         self.manager?.request(.customGetURL(with: .activitydetails, components: ["ClientID":clientId,"Days":days!]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let activitymodel = try JSONDecoder().decode([ActivityDataModel].self, from: dictResponse as! Data)
                        self.activityarray = activitymodel
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
    
    var activityarray: [ActivityDataModel] = []
    
    
}
