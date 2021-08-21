//
//  RunningHistoryViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/08/21.
//

import Foundation
protocol RunningHistoryViewModelProtocol : class {
    func getRunningHistoryDetails(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var runninghistoryarray:[RunningHistoryDataModel]{get}
}
class RunningHistoryViewModel:RunningHistoryViewModelProtocol {
   
    var manager: RequestManager?
    var runninghistoryarray: [RunningHistoryDataModel] = []
    func getRunningHistoryDetails(completion: @escaping (ProcessBot<Any?>) -> Void) {
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
     self.manager?.request(.customGetURL(with: .runninghistorydetails, components: ["ClientID":clientId,"Hours":"24"]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let runninghistorymodel = try JSONDecoder().decode([RunningHistoryDataModel].self, from: dictResponse as! Data)
                        self.runninghistoryarray = runninghistorymodel
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
