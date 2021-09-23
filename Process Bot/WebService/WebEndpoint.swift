//
//  WebEndpoint.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 02/08/21.
//

import Foundation

public struct Endpoint {
    var base: String
    var path: String
}

extension Endpoint {
    
    var url: URL {
        let urlstring = base + "/" + path
        let allowedCharacterSet = (CharacterSet(charactersIn: "|").inverted)

        let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? ""
        //do something with escaped string
     
        guard let url = URL(string: escapedString) else {
        //(string: base + "/" + path) else {
            preconditionFailure(
                "Invalid URL: \(base + "/" + path)"
            )
        }
       return url
    }
}

//All URLs are defined here. But Endpoint can be decoupled.
extension Endpoint {
    
    static var login: Self {
        Endpoint(base:environment.baseURL, path: "api/app/UserLogin")
    }
    
    static var getToken: Self {
        Endpoint(base:environment.baseURL, path: "api/oauth2/Token")
    }
    
    static var allWorkerRobot: Self {
        Endpoint(base:environment.baseURL, path: "api/Workers/All")
    }
    
    static var scheduleRobotList: Self {
       Endpoint(base:environment.baseURL, path: "api/Tasks/ScheduleList?=")
    }
   
    
    static var publishedRobot: Self {
        Endpoint(base:environment.baseURL, path: "api/Scripts/PublishedScript?")
    }

    static var InActionRobot: Self {
        Endpoint(base:environment.baseURL, path: "api/Workers/CurrentTaskList?")
    }

    static var logHistoryRobotList: Self {
        Endpoint(base:environment.baseURL, path: "api/Tasks/History?")
        //api/Tasks/RobotHistory?
       // Endpoint(base:environment.baseURL, path: "api/Tasks/RobotHistory?")
    }
    
    static var logHistoryRobotDetails: Self {
        Endpoint(base:environment.baseURL, path: "api/Workers/EventDetails?")
    }
    
    static var InactionDetails: Self {
        Endpoint(base:environment.baseURL, path: "api/Workers/CurrentTaskDetails?")
    }
    
    static var RunRobot: Self {
        Endpoint(base:environment.baseURL, path: "api/Tasks/Schedule")
    }
    
    static var notification: Self {
        Endpoint(base:environment.baseURL, path: "APP/notifications")
    }
    static var stopPauseRobot:Self
        {
            Endpoint(base:environment.baseURL, path: "api/Tasks/PausedStop")
            
        }
    static var directorydetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/User/DirectoryList?")
        
    }
    static var performerdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/Dashboard/TopTenRobotPerformer?")
    }
   
    static var nonperformerdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/Dashboard/TopTenRobotError?")
    }
    
    static var costsavingsdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/Dashboard/DirectrywiseROI?")
    }
    static var successratedetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/DashBoard/RobotsSuccessRate?")
    }
    static var activitydetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/DashBoard/Activity?")
    }
    static var runninghistorydetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/DashBoard/HourlyActivity?")
    }
    
    static var machinehostdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/Workers/All")
    }
    
    static var userslistdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/User/UserList?")
    }
    static var roleslistdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/User/RoleList?")
    }
    static var permissionlistdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/User/PermissionList?")
    }
    static var profilelistdetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/Customer/CustomerList?")
    }
    static var licencedetails:Self
    {
        Endpoint(base:environment.baseURL, path: "api/Customer/CurrentLicense?")
    }
    
    static var timezonelist:Self
    {
        Endpoint(base:environment.baseURL, path: "api/System/TimezoneList?")
    }
    
  
    static func customGetURL(with endpoint:Self, components:[String:Any]) -> Self {
        
        var modifiedPath = endpoint.path
        for element in components.keys {
            if let value = components[element] {
                modifiedPath += "&\(element)=\(value)"
            }
        }
        return Endpoint(base:environment.baseURL, path: modifiedPath)
    }
}
