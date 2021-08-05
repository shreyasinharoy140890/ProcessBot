//
//  WebEndpoint.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 02/08/21.
//

import Foundation

public enum ProcessBotNetWorkrror: Error {
    case jsonEncodingFailed(error: Error)
    case urlEncodingFailed
    case missingURL
    
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case clientError
    
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case serverError
    
    case failed
    case noData
    case noResponse
    case offLine
    case customError(msg: String)
}

extension ProcessBotNetWorkrror: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .jsonEncodingFailed(error):
            return "JSON could not be encoded because of error:\n\(error.localizedDescription)"
        case .urlEncodingFailed:
            return "URL could not be encoded."
        case .missingURL:
            return "URL is nil."
            
        case .badRequest:
            return "Bad request. The server cannot process the request."
        case .unauthorized:
            return "Unauthorized access. Authentication credentials is missing."
        case .forbidden:
            return "The requested resource is forbidden for some reason."
        case .notFound:
            return "The requested resource has not been found."
        case .clientError:
            return "Client error. The error seems to have been caused by some misconfigration of request."
           
        case .internalServerError:
            return "Internal server error. Please try again later."
        case .notImplemented:
            return "The server either does not recognize the request method."
        case .badGateway:
            return "Bad gateway. Something wrong with a server communication."
        case .serviceUnavailable:
            return "Service unavailable due to overload or down for maintenance."
        case .gatewayTimeout:
            return "Gateway timeout. The server was acting as a gateway or proxy and did not receive a timely response."
        case .serverError:
            return "Server error. The server failed to perform a request."
            
        case .failed:
            return "Network request failed. Please try again."
        case .noData:
            return "Response returned with no data.Please try again later"
        case .noResponse:
            return "No response available."
        case .offLine:
            return "You are offline now. Please check your internet connection."
        case let .customError(msg):
            return "\(msg)"
            
        /*case let .bodyPartFileNotReachableWithError(url, error):
            return """
            The system returned an error while checking the provided URL for reachability.
            URL: \(url)
            Error: \(error)
            """*/
        }
    }
}
