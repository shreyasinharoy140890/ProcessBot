//
//  NetworkLogger.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    
    static func log(data: Data?, response: URLResponse?) {
        print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        guard let response = response as? HTTPURLResponse else { return }
       
        let logOutput = """
            STATUS CODE: \(response.statusCode)
            \(description(for: response.headers).indentingNewlines())
            \(description(for: data, headers: response.headers).indentingNewlines())
        """
        
        print(logOutput)
    }
    
    static func log(url: URL?, response: URLResponse?) {
        print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        guard let response = response as? HTTPURLResponse else { return }
       
        let logOutput = """
            STATUS CODE: \(response.statusCode)
            \(description(for: response.headers).indentingNewlines())
            LOCAL URL: \(url?.absoluteString.indentingNewlines() ?? "None")
        """
        
        print(logOutput)
    }
    
    static func description(for headers: HTTPHeaders) -> String {
        guard !headers.isEmpty else { return "HEADERS: None" }

        let headerDescription = "\(headers.sorted())".indentingNewlines()
        return """
        HEADERS:
            \(headerDescription)
        """
    }
    
    static func description(for data: Data?,
                            headers: HTTPHeaders,
                            allowingPrintableTypes printableTypes: [String] = ["json", "xml", "text"],
                            maximumLength: Int = 100_000) -> String {
        guard let data = data, !data.isEmpty else { return "[Body]: None" }

        guard
            data.count <= maximumLength,
            printableTypes.compactMap({ headers["Content-Type"]?.contains($0) }).contains(true)
        else { return "BODY: \(data.count) bytes" }

        return """
        BODY:
            \(String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .indentingNewlines())
        """
    }
}

extension String {
    fileprivate func indentingNewlines(by spaceCount: Int = 4) -> String {
        let spaces = String(repeating: " ", count: spaceCount)
        return replacingOccurrences(of: "\n", with: "\n\(spaces)")
    }
}
