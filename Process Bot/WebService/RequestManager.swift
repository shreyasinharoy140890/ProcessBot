//
//  RequestManager.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 02/08/21.
//


import Foundation

typealias CompletionHandler = (ProcessBot<Any?>) -> Void

/*public enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}*/

class RequestManager {
    
    //static let `default` = RequestManager()
    
    /// Create  a URLSessionDataTask.
    /// - Parameters:
    ///   - endpoint: `Endpoint` value to be used as the `URLRequest`'s `URL`.
    ///   - method: `HTTPMethod` for the `URLRequest`. `.get` by default.
    ///   - parameters: `Parameters` (a dictionary of type `[String: Any]`)  value to be encoded into the `URLRequest`. `nil` by default.
    ///   - encoding: `ParameterEncoding` to be used to encode the `parameters` value into the `URLRequest`. `.json` by default.
    ///   - headers: `HTTPHeaders`(`HTTPHeader` objetc or  a  dictionary of type `[String: Any]`)  value to be added to the `URLRequest`. `nil` by default.
    ///   - completion: The completion handler for the data task. Its typically an result type i.e, ` TCSResult<Any?>`
    
    @discardableResult
    func request(_ endpoint: Endpoint, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding:ParameterEncoding = .json, headers: HTTPHeaders? = nil, handler: @escaping CompletionHandler) -> Router {
        
        let router = Router(endpoint: endpoint,
                            method: method,
                            parameters: parameters,
                            encoder: encoding,
                            headers: headers)
        router.dataRequest { (data, response, error) in
            let result = self.validateResponse(data, response as? HTTPURLResponse, error)
            DispatchQueue.main.async {
                handler(result)
            }
        }
        return router
    }
    
    /// Create  a URLSessionDownloadTask.
    /// - Parameters:
    ///   - endpoint: `Endpoint` value to be used as the `URLRequest`'s `URL`.
    ///   - method: `HTTPMethod` for the `URLRequest`. `.get` by default.
    ///   - parameters: `Parameters` (a dictionary of type `[String: Any]`)  value to be encoded into the `URLRequest`. `nil` by default.
    ///   - encoding: `ParameterEncoding` to be used to encode the `parameters` value into the `URLRequest`. `.json` by default.
    ///   - headers: `HTTPHeaders`(`HTTPHeader` objetc or  a  dictionary of type `[String: Any]`)  value to be added to the `URLRequest`. `nil` by default.
    ///   - completion: The completion handler for the download task. Its typically an result type i.e, ` TCSResult<Any?>`
    
    @discardableResult
    func download(_ endpoint: Endpoint, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding:ParameterEncoding = .json, headers: HTTPHeaders? = nil, handler: @escaping CompletionHandler) -> Router {
            let router = Router(endpoint: endpoint,
                                method: method,
                                parameters: parameters,
                                encoder: encoding,
                                headers: headers)
            router.downloadRequest(progressHandler: nil) {(url, response, error) in
                let result = self.validateResponse(url, response as? HTTPURLResponse, error)
                DispatchQueue.main.async {
                    handler(result)
                }
            }
            return router
        }
    

    
    
    /// Create  a URLSessionUploadTask.
    /// - Parameters:
    ///   - endpoint: `Endpoint` value to be used as the `URLRequest`'s `URL`.
    ///   - method: `HTTPMethod` for the `URLRequest`. `.get` by default.
    ///   - parameters: `Parameters` (a dictionary of type `[String: Any]`)  value to be encoded into the `URLRequest`. `nil` by default.
    ///   - encoding: `ParameterEncoding` to be used to encode the `parameters` value into the `URLRequest`. `.json` by default.
    ///   - headers: `HTTPHeaders`(`HTTPHeader` objetc or  a  dictionary of type `[String: Any]`)  value to be added to the `URLRequest`. `nil` by default.
    ///   - completion: The completion handler for the upload task. Its typically an result type i.e, ` TCSResult<Any?>`
    
    @discardableResult
    func upload(_ endpoint: Endpoint, fileURL:URL, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding:ParameterEncoding = .json, headers: HTTPHeaders? = nil, handler: @escaping CompletionHandler) -> Router {
        
        let router = Router(endpoint: endpoint,
                            method: method,
                            parameters: parameters,
                            encoder: encoding,
                            headers: headers)
        router.uploadRequest(from: fileURL) {(data, response, error) in
            let result = self.validateResponse(data, response as? HTTPURLResponse, error)
            DispatchQueue.main.async {
                handler(result)
            }
        }
        return router
    }
    
    
    private func validateResponse(_ data:Any?, _ response: HTTPURLResponse?, _ error: Error?) -> ProcessBot<Any?>{
        guard let response = response else {
            return .failure(ProcessBotNetWorkrror.noData)
        }
        
        switch response.statusCode {
        // 2xx
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(ProcessBotNetWorkrror.noData)
            }
        // 4xx
        case 400:
            if let data = data {
                return .success(data)
            } else {
                return .failure(ProcessBotNetWorkrror.badRequest)
            }
        case 401:
            if let data = data {
                return .success(data)
            } else {
                return .failure(ProcessBotNetWorkrror.unauthorized)
            }
        case 403:
            if let data = data {
                return .success(data)
            } else {
                return .failure(ProcessBotNetWorkrror.forbidden)
            }
        case 404: return .failure(ProcessBotNetWorkrror.notFound)
        case 405...499: return .failure(ProcessBotNetWorkrror.customError(msg: error?.localizedDescription ?? ProcessBotNetWorkrror.clientError.localizedDescription))
        // 5xx
        case 500: return .failure(ProcessBotNetWorkrror.internalServerError)
        case 501: return .failure(ProcessBotNetWorkrror.notImplemented)
        case 502: return .failure(ProcessBotNetWorkrror.serviceUnavailable)
        case 503: return .failure(ProcessBotNetWorkrror.badGateway)
        case 504: return .failure(ProcessBotNetWorkrror.gatewayTimeout)
        case 505...599: return .failure(ProcessBotNetWorkrror.customError(msg: error?.localizedDescription ?? ProcessBotNetWorkrror.serverError.localizedDescription))
        // Fallback to default if no status code matches
        default: return .failure(ProcessBotNetWorkrror.failed)
        }
    
    }
}

