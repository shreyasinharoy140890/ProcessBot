//
//  RobotListViewModel.swift
//  Process Bot
//
//  Created by Appsbee on 08/12/21.
//

import Foundation
protocol AssignmentListViewModelProtocol : class {
    func getassignmentList(completion:@escaping (ProcessBot<Any?>) -> Void)
    var manager: RequestManager? { get set }
    var assignmentlist:[AssignmentListModel]!{get}
}
class AssignmentListViewModel:AssignmentListViewModelProtocol
{
    var manager: RequestManager?
    
    var assignmentlist: [AssignmentListModel]!
    
    func getassignmentList(completion: @escaping (ProcessBot<Any?>) -> Void) {
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
        guard let directoryID  = UserDefaults.standard.value(forKey: "DIRECTORYID") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
        // let dictParams:[String:Any] = ["ClientID": clientId]
         let headers : HTTPHeaders = [
             "Token": "\(token)",
             "AppName":"IntelgicApp"
         ]

        self.manager?.request(.customGetURL(with: .getAssignmentList, components: ["ClientID":clientId,"UserID":userId,"DirectoryID":directoryID]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
             
             switch result {
             case .success(let jsonresponce):
                 if let dictResponse = jsonresponce {
                     print(dictResponse)
                     do{
                         let assignmentmodel = try JSONDecoder().decode([AssignmentListModel].self, from: dictResponse as! Data)
                         self.assignmentlist = assignmentmodel

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
