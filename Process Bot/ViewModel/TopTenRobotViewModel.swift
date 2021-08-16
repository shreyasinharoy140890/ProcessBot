//
//  TopTenRobotViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 13/08/21.
//

import Foundation
protocol TopTenRobotViewModelProtocol : class {
    func getPerformerList(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var performerdetails:[topTenRobotDataModel]{get}
}
class TopTenRobotViewModel:TopTenRobotViewModelProtocol {
    var manager: RequestManager?
    
    var performerdetails: [topTenRobotDataModel] = []
    
    func getPerformerList(completion: @escaping (ProcessBot<Any?>) -> Void) {
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
          
         
         
        self.manager?.request(.customGetURL(with: .performerdetails, components: ["ClientID":clientId]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([topTenRobotDataModel].self, from: dictResponse as! Data)
                         self.performerdetails = directorymodel

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
    
 

    

