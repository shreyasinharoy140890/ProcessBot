//
//  RobotViewModel.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 05/08/21.
//

import Foundation

protocol RobotViewModelProtocol : class {
    func getSearchRobotName(completion:@escaping (ProcessBot<Any?>) -> Void)
    var searchRobotString: String? {get set}
    var arrayimg:[[String]] {get set}
    var dataarray:[[String]] {get set}
    var manager: RequestManager? { get set }
    func callScheduleRobot( completion:@escaping (ProcessBot<Any?>)-> Void)
    var arraySchedule:[ScheduleModel]{get}
    func callPublishRobot( completion:@escaping (ProcessBot<Any?>)-> Void)
    var arrayPublish:[PublishedRobotModel]{get set}
    func callInActionRobot( completion:@escaping (ProcessBot<Any?>)-> Void)
    var arrayInAction:[InActionModel] {get}
    func callLogHistory( completion:@escaping (ProcessBot<Any?>)-> Void)
    var arrayLogHistory:[logHistoryModel]{get}
    var arrayPublishDataStore:[PublishedRobotModel]{get set}
}
class RobotViewModel:RobotViewModelProtocol {
    var manager: RequestManager?
    var arraySchedule = [ScheduleModel]()
    var arrayimg = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","Nick Maybury"],["user_pic6","Marino viola"],["user_pic7","Nicholas Isley"]]
    var dataarray = [["user_pic1","David Thomas"],["user_pic2","William corry"],["user_pic3","Jhon deo"],["user_pic4","Bill gates"],["user_pic5","Nick Maybury"],["user_pic6","Marino viola"],["user_pic7","Nicholas Isley"]]
    var arrayPublish = [PublishedRobotModel]()
    var arrayInAction = [InActionModel]()
    var arrayPublishDataStore = [PublishedRobotModel]()
    
    var arrayLogHistory = [logHistoryModel]()
    
    var searchRobotString: String?
    
    
    func getSearchRobotName(completion:@escaping (ProcessBot<Any?>) -> Void){
        if let searchtext = searchRobotString {
            let filteredArray = arrayPublish.filter { (modelObject) -> Bool in
                return modelObject.friendlyName?.range(of: searchtext, options: String.CompareOptions.caseInsensitive) != nil || modelObject.machineName?.range(of: searchtext, options: String.CompareOptions.caseInsensitive) != nil
            }
            print(filteredArray as Any)
            if (filteredArray as NSArray).count > 0{
                self.arrayPublish = filteredArray
                completion(.success(true))
            }else {
                self.arrayPublish = filteredArray
                completion(.failure(ProcessBotError.customMessage("Some thing went wrong. Please try again later".localized())))
            }
        }else {
            self.arrayPublish = self.arrayPublishDataStore
        }
    }
    
    func callScheduleRobot( completion:@escaping (ProcessBot<Any?>)-> Void){
        
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
         
        
        
        self.manager?.request(.customGetURL(with: .scheduleRobotList, components: ["ClientID":clientId]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
            
            switch result {
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    print(dictResponse)
                    do{
                        let schedulemodel = try JSONDecoder().decode([ScheduleModel].self, from: dictResponse as! Data)
                        self.arraySchedule = schedulemodel

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
    
    func callPublishRobot( completion:@escaping (ProcessBot<Any?>)-> Void){
        
       guard let token  = UserDefaults.standard.value(forKey: "TOKEN") else {
            completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
            return
        }
        guard let clientId  = UserDefaults.standard.value(forKey: "CLIENTID") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
        guard let userid  = UserDefaults.standard.value(forKey: "USERID") else {
             completion(.failure(ProcessBotError.customMessage("Please try after sometimes")))
             return
         }
       // let dictParams:[String:Any] = ["ClientID": clientId]
        let headers : HTTPHeaders = [
            "Token": "\(token)",
            "AppName":"IntelgicApp"
        ]
         
        
        
        self.manager?.request(.customGetURL(with: .publishedRobot, components: ["ClientID":clientId,"DirectoryID":"1","UserID":userid,"PublishedScriptID":""]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
            
            switch result {
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    print(dictResponse)
                    do{
                        let publishmodel = try JSONDecoder().decode([PublishedRobotModel].self, from: dictResponse as! Data)
                        self.arrayPublish = publishmodel
                        self.arrayPublishDataStore = publishmodel

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
    
    
    func callInActionRobot( completion:@escaping (ProcessBot<Any?>)-> Void){
        
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
         
        
        
        self.manager?.request(.customGetURL(with: .InActionRobot, components: ["ClientID":clientId,"DirectoryID":1]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
            
            switch result {
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    print(dictResponse)
                    do{
                        let inaction = try JSONDecoder().decode([InActionModel].self, from: dictResponse as! Data)
                        self.arrayInAction = inaction

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
    func callLogHistory( completion:@escaping (ProcessBot<Any?>)-> Void){
        
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
         
        
        
        self.manager?.request(.customGetURL(with: .logHistoryRobotList, components: ["ClientID":clientId,"DirectoryID":1,"pageSize":50,"page":1]), method: .get,parameters: nil, encoding: .json, headers: headers, handler:   { (result) in
            
            switch result {
            case .success(let jsonresponce):
                if let dictResponse = jsonresponce {
                    print(dictResponse)
                    do{
                        let inaction = try JSONDecoder().decode([logHistoryModel].self, from: dictResponse as! Data)
                        self.arrayLogHistory = inaction

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
