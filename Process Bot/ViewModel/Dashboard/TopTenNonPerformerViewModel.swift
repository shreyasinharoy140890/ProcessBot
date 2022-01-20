//
//  TopTenNonPerformer.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 16/08/21.
//

import Foundation
protocol TopTenNonPerformerViewModelProtocol : class {
    func getnonPerformerList(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var nonperformerdetails:[TopTenNonPerformerDataModel]{get}
}
class  TopTenNonPerformerViewModel:TopTenNonPerformerViewModelProtocol {
    var manager: RequestManager?
    
    var nonperformerdetails: [TopTenNonPerformerDataModel] = []
    
    func getnonPerformerList(completion: @escaping (ProcessBot<Any?>) -> Void) {
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
          
         
         
        self.manager?.request(.customGetURL(with: .nonperformerdetails, components: ["ClientID":clientId]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let directorymodel = try JSONDecoder().decode([TopTenNonPerformerDataModel].self, from: dictResponse as! Data)
                         self.nonperformerdetails = directorymodel

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
    
 

    

