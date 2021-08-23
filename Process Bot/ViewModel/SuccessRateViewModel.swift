//
//  SuccessRateViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/08/21.
//

import Foundation
protocol SuccessRateViewModelProtocol : class {
    func getSuccessRateDetails(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var successratearray:[SuccessRateDataModel]{get}
}
class SuccessRateViewModel:SuccessRateViewModelProtocol {
    var manager: RequestManager?
    var successratearray: [SuccessRateDataModel] = []
    func getSuccessRateDetails(completion: @escaping
        (ProcessBot<Any?>) -> Void) {
            guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
                 completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
                 return
             }
             guard let clientId  = UserDefaults.standard.value(forKey: "CLIENTID") else {
                  completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
                  return
              }
             let headers : HTTPHeaders = [
                 "Token": "\(token)",
                 "AppName":"IntelgicApp"
             ]
         self.manager?.request(.customGetURL(with: .successratedetails, components: ["ClientID":clientId,"Days":"30"]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
                 
                 switch result {
                 case .success(let jsonresponce):
                     if let dictResponse = jsonresponce {
                         print(dictResponse)
                         do{
                             let successratemodel = try JSONDecoder().decode([SuccessRateDataModel].self, from: dictResponse as! Data)
                            print(successratemodel)
//                            self.successratearray = successratemodel
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
    

