//
//  URLEncoding.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw ProcessBotNetWorkrror.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = parameters.map {
              URLQueryItem(name: $0, value: "\($1)")
            }
            
            /*urlComponents.queryItems = [URLQueryItem]()

            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                urlComponents.queryItems?.append(queryItem)
            }*/
            
            guard let newURL = urlComponents.url else {
                throw ProcessBotNetWorkrror.urlEncodingFailed
            }
            
            urlRequest.url = newURL
        }
        
        /*if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }*/
        
    }
}
