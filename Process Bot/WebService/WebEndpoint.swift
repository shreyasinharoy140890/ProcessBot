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
    
    static var purchase: Self {
        Endpoint(base:environment.baseURL, path: "APP/purchase")
    }
    
    static var document: Self {
        Endpoint(base:environment.baseURL, path: "APP/documents")
    }
    
    static var purchasedTickets: Self {
        Endpoint(base:environment.baseURL, path: "APP/ticketsParallel")
    }

    static var activateTicket: Self {
        Endpoint(base:environment.baseURL, path: "APP/activate")
    }

    static var alreadyActivatedTicket: Self {
        Endpoint(base:environment.baseURL, path: "APP/activeTickets")
    }
    
    static var availableTicket: Self {
        Endpoint(base:environment.baseURL, path: "APP/availableTickets")
    }
    
    static var ticketHistory: Self {
        Endpoint(base:environment.baseURL, path: "APP/history")
    }
    
    static var addBenefit: Self {
        Endpoint(base:environment.baseURL, path: "APP/benifit")
    }
    
    static var notification: Self {
        Endpoint(base:environment.baseURL, path: "APP/notifications")
    }
    

}
