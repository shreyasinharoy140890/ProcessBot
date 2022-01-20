//
//  CostSavingsViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 16/08/21.
//

import Foundation
protocol CostSavingsViewModelProtocol : class {
    func getSavingsList(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var costsavingsdetails:[CostsavingsDataModel]{get}
}
class CostSavingsViewModel:CostSavingsViewModelProtocol {
    var manager: RequestManager?
    var period:Int?
    var costsavingsdetails: [CostsavingsDataModel] = []
    func getSavingsList(completion: @escaping (ProcessBot<Any?>) -> Void) {
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
          

            period = UserDefaults.standard.value(forKey: "PERIOD") as? Int
            print(period!)
        

        self.manager?.request(.customGetURL(with: .costsavingsdetails, components: ["ClientID":clientId,"period":period!]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([CostsavingsDataModel].self, from: dictResponse as! Data)
                         self.costsavingsdetails = directorymodel

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
    
    
    

