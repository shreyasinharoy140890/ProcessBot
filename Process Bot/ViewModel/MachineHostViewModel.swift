//
//  MachineHostViewModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 31/08/21.
//

import Foundation
protocol MachineHostViewModelProtocol : class {
    func machineHostDetails(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var machinearray:[MachineHostModel]{get}
}
class MachineHostViewModel:MachineHostViewModelProtocol {
    var manager: RequestManager?
    
    var machinearray: [MachineHostModel] = []
    
    func machineHostDetails(completion: @escaping (ProcessBot<Any?>) -> Void) {
        guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
         
         let headers : HTTPHeaders = [
             "Token": "\(token)",
             "AppName":"IntelgicApp"
         ]
        self.manager?.request(.machinehostdetails, method: .get, parameters: nil, encoding: .json, headers: headers, handler:    { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let machinehostmodel = try JSONDecoder().decode([MachineHostModel].self, from: dictResponse as! Data)
                        self.machinearray = machinehostmodel
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
    
    
