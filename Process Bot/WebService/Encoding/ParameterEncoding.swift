//
//  ParameterEncoding.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case url
    case json
    //case urlAndJson
    
    public func encode(urlRequest: inout URLRequest,
                       parameters: Parameters?) throws {
        do {
            switch self {
            case .url:
                guard let urlParameters = parameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .json:
                guard let bodyParameters = parameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            /*case .urlAndJson:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)*/
                
            }
        }catch {
            throw error
        }
    }
}
