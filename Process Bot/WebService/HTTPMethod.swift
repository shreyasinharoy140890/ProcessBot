//
//  HTTPMethod.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 02/08/21.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    // `GET` method
    public static let get = HTTPMethod(rawValue: "GET")
    // `POST` method.
    public static let post = HTTPMethod(rawValue: "POST")
    // `PUT` method
    public static let put = HTTPMethod(rawValue: "PUT")
    // `PATCH` method
    public static let patch = HTTPMethod(rawValue: "PATCH")
    // `DELETE` method
    public static let delete = HTTPMethod(rawValue: "DELETE")
    
 
}
