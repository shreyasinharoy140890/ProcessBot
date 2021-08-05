//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

typealias NetworkRouterRequestCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()
typealias NetworkRouterDownloadCompletion = (_ url: URL?,_ response: URLResponse?,_ error: Error?) -> Void

typealias ProgressHandler = (Float) -> Void
typealias ProgressAndCompletionHandlers = (progress: ProgressHandler?, completion: NetworkRouterDownloadCompletion?)
//public typealias HTTPHeaders = [String: String]

protocol NetworkRouter {
    //associatedtype RouterPoint: EndPointType
    
    /// Required initializer.
    /// - Parameters:
    ///   - endpoint: An endpoint of a specific service
    ///   - method: A `HTTPMethod` i.e, `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
    ///   - parameters: A dictonary of parameters.
    ///   - encoding: A `ParameterEncoding` type  i.e, ` url` or ` json`
    ///   - headers: A  `[String: String]` type  for `allHTTPHeaderFields` of `URLRequest`
    init(endpoint:Endpoint, method:HTTPMethod, parameters:Parameters?, encoder:ParameterEncoding?, headers:HTTPHeaders?)
    
    /// Create  a URLSessionDataTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - completion: The completion handler for the data task.
    func dataRequest(completion: @escaping NetworkRouterRequestCompletion)
    
    /// Create  a URLSessionDownloadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completionHandler: The completion handler for the download task.
    func downloadRequest(progressHandler: ProgressHandler?, completion: @escaping NetworkRouterDownloadCompletion)
    
    /// Create  a URLSessionUploadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - fileURL: The source file `URL`.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completion: he completion handler for the upload task.
    func uploadRequest(from fileURL: URL, progressHandler: ProgressHandler?, completion: @escaping NetworkRouterRequestCompletion)
    
    /// Resume an suspend task. By default its getting called when execute any request .
    func resume()
    
    /// Suspend an ongoing task.
    func suspend()
    
    /// Cancel an ongoing task.
    func cancel()
}



class Router: NSObject, NetworkRouter {
    private let endpoint: Endpoint
    private let method: HTTPMethod
    private let parameters: Parameters?
    private let encoder: ParameterEncoding?
    private let headers: HTTPHeaders?
    
    private var session: URLSession!
    private var task: URLSessionTask?
    private lazy var taskToHandlersMap: [URLSessionTask : ProgressAndCompletionHandlers] = [:]
    
    var destination: URL?
    
    required init(endpoint:Endpoint, method:HTTPMethod, parameters:Parameters?, encoder:ParameterEncoding?, headers:HTTPHeaders?) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.encoder = encoder
        self.headers = headers
        
        if !InternetStatus.shared.isMonitoring {
            InternetStatus.shared.startMonitoring()
        }
    }

    func dataRequest(completion: @escaping NetworkRouterRequestCompletion) {
        if InternetStatus.shared.isConnected {
            session = self.initiateSession()
            do {
                let request = try self.buildRequest()
                NetworkLogger.log(request: request)
                task = session.dataTask(with: request, completionHandler: { data, response, error in
                    NetworkLogger.log(data: data, response: response)
                    completion(data, response, error)
                })
                task?.resume()
            } catch {
                completion(nil, nil, error)
            }
        }
        else {
            completion(nil, nil, ProcessBotError.noNetwork)
        }
    }
    
    func downloadRequest(progressHandler: ProgressHandler?, completion: @escaping NetworkRouterDownloadCompletion) {
        if InternetStatus.shared.isConnected {
            session = self.initiateSession()
            do {
                let request = try self.buildRequest()
                task = session.downloadTask(with: request)
                // Set the associated progress and completion handlers for this task.
                set(handlers: (progressHandler, completion), for: task!)
                task?.resume()
            } catch {
                completion(nil, nil, error)
            }
        }
        else {
            completion(nil, nil, ProcessBotError.noNetwork)
        }
    }
    
    func uploadRequest(from fileURL: URL, progressHandler: ProgressHandler? = nil, completion: @escaping NetworkRouterRequestCompletion) {
        session = self.initiateSession()
        do {
            let request = try self.buildRequest()
            task = session.uploadTask(with: request, fromFile: fileURL, completionHandler: { (data, urlResponse, error) in
                NetworkLogger.log(data: data, response: urlResponse)
                completion(data, urlResponse, error)
            })
            // Set the associated progress handler for this task.
            set(handlers: (progressHandler, nil), for: task!)
            task?.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func resume() {
        task?.resume()
    }
    
    func suspend() {
        task?.cancel()
    }
    
    func cancel() {
        task?.cancel()
    }
    

    /// Initiate `URLSession` with `URLSessionConfiguration` , `OperationQueue` and `URLSessionDelegate`
    /// - Parameters: `URLSessionDelegate`
    /// -  Returns: `URLSession` instance.
    private func initiateSession() -> URLSession {
        // Configure the default URLSessionConfiguration.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        sessionConfiguration.waitsForConnectivity = true
            
        if #available(iOS 13, *) {
            sessionConfiguration.allowsExpensiveNetworkAccess = true
        }

        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        return URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: queue)
    }
    
    /// Prepare `URLRequest`
    /// -  Returns: `URLRequest` instance.
    private func buildRequest() throws -> URLRequest {
        
        var request = URLRequest(url: endpoint.url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 180.0)
        
        request.httpMethod = method.rawValue
        
        // Add headers if any
        if var headersFields = self.headers {
            headersFields.add(HTTPHeader.userAgent(UserAgentBuilder.UAString()))
            request.headers = headersFields
        }
        
        do {
            try self.configureParameters(params: parameters, encoding: encoder ?? .json, request: &request)
            return request
        } catch {
            throw error
        }
    }
    
    /// Encodes  parameters into  instance `URLRequest` based on `ParameterEncoding` type
    /// - Parameters:
    ///   - params: `Parameters` a dictionary
    ///   - encoding: `ParameterEncoding`, url or json
    ///   - request: `URLRequest` instance.
    private func configureParameters(params: Parameters?, encoding: ParameterEncoding, request: inout URLRequest) throws {
        do {
            try encoding.encode(urlRequest: &request, parameters: params)
        } catch {
            throw error
        }
    }
    
    /// Associates a `URLSessionTask` instance with its `ProgressAndCompletionHandlers`
    /// - Parameters:
    ///   - handlers: `ProgressAndCompletionHandlers` tuple.
    ///   - task: `URLSessionTask` instance.
    private func set(handlers: ProgressAndCompletionHandlers?, for task: URLSessionTask) {
            taskToHandlersMap[task] = handlers
        }

    /// Fetches the `ProgressAndCompletionHandlers` for a given `URLSessionTask`.
    /// - Parameter task: `URLSessionTask` instance.
    /// - Returns: `ProgressAndCompletionHandlers` optional instance.
    private func getHandlers(for task: URLSessionTask) -> ProgressAndCompletionHandlers? {
        return taskToHandlersMap[task]
    }
    
    deinit {
        // We have to invalidate the session becasue URLSession strongly retains its delegate. https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel
        if (session != nil){
        session.invalidateAndCancel()
        session = nil
        }
    }
}


extension Router: URLSessionDelegate {

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let handlers = getHandlers(for: task) else {
            return
        }

        let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
        //  Remove the associated handlers.
        set(handlers: nil, for: task)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let downloadTask = task as? URLSessionDownloadTask,
            let handlers = getHandlers(for: downloadTask) else {
            return
        }

        DispatchQueue.main.async {
            handlers.completion?(nil, downloadTask.response, downloadTask.error)
        }

        //  Remove the associated handlers.
        set(handlers: nil, for: task)
    }
}


extension Router: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let handlers = getHandlers(for: downloadTask) else {
            return
        }
        NetworkLogger.log(url: location, response: downloadTask.response)
        
        /// https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1411575-urlsession
        /// A file URL for the temporary file. Because the file is temporary, you must either open the file for reading or move it to a permanent location in your app’s sandbox container directory before returning from this delegate method.
        /// If you choose to open the file for reading, you should do the actual reading in another thread to avoid blocking the delegate queue.
        
        // Move to a permanent location even if destionation location is not provided
        if self.destination == nil {
            let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileName = "Downloaded_file\(downloadTask.response?.suggestedFilename ?? "")"
            
            self.destination = docsURL.appendingPathComponent(fileName)
        }
        
        if let destionationURL = self.destination {
            do {
                // Move file from temporary location to permanent location
                try FileManager.default.moveItem(at: location, to: destionationURL)
                
                DispatchQueue.main.async {
                    handlers.completion?(destionationURL, downloadTask.response, downloadTask.error)
                }
            } catch {
                // Handle error
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    handlers.completion?(nil, downloadTask.response, error)
                }
            }
        }
        else {
            DispatchQueue.main.async {
                handlers.completion?(nil, downloadTask.response, ProcessBotNetWorkrror.customError(msg: "Destination path is not provided."))
            }
        }
        
        //  Remove the associated handlers.
        set(handlers: nil, for: downloadTask)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let handlers = getHandlers(for: downloadTask) else {
            return
        }
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print("UPLOAD PROGRESS: progress")
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
    }
}
