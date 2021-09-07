//
//  SuccessRateViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/08/21.
//

import Foundation
//protocol SuccessRateViewModelProtocol : class {
//    func getSuccessRateDetails(completion:@escaping (ProcessBot<Any?>) -> Void)
//    var manager: RequestManager? { get set }
//    var successratearray:[SuccessRateDataModel]{get}
//}


class SuccessRateViewModel {
    
    // MARK: - Initialization
    init(model: SuccessRateDataModel? = nil) {
        if let inputModel = model {
            rates = inputModel
        }
    }
    var rates:SuccessRateDataModel?
    var manager: RequestManager? 

}
extension SuccessRateViewModel {
    func getSuccessRateDetails(completion: @escaping (ProcessBot<Any?>) -> Void) {
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
        self.manager?.request(.customGetURL(with: .successratedetails, components: ["ClientID":clientId,"Days":"30"]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
                
                switch result {
                case .success(let jsonresponce):
                    if let dictResponse = jsonresponce {
                        print(dictResponse)
                     
                        do{
                            self.rates = try JSONDecoder().decode(SuccessRateDataModel.self, from: dictResponse as! Data)
                                                        completion(.success(try JSONDecoder().decode(SuccessRateDataModel.self, from: dictResponse as! Data)))
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

