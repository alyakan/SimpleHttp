//
//  SimpleHTTP.swift
//  SimpleHTTP
//
//  Created by Aly Yakan on 5/5/17.
//  Copyright © 2017 cookiecutter-swift. All rights reserved.
//

import Foundation

struct SimpleHTTP {
    private init() {}
    
    fileprivate static var requestQueue:[SimpleHTTPRequest] = []
    fileprivate static var requestsInProcessing: Int = 0
    
    /**
     It tries to enqueue the request into a request queue for later execution.
     
     - Parameter request: A SimpleHttpRequest Optional Object.
     - Returns: A boolean indicating the success or failure of enqueuing the request.
     */
    public static func enqueue(request: SimpleHTTPRequest?) -> Bool {
        let previousCount = requestQueue.count
        if let request = request {
            requestQueue.append(request)
        }
        return requestQueue.count == previousCount + 1
    }
    
    public static func enqueue(withUrl url: URL, httpMethod: HTTPMethod, parameters: NSDictionary?) -> Bool {
        let previousCount = requestQueue.count
        if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: httpMethod, parameters: parameters) {
            requestQueue.append(simpleRequest)
        }
        return requestQueue.count == previousCount + 1
    }
    
    /**
     It dequeues the first request in the request queue.
     
     - Returns: A SimpleHttpRequest Object.
     */
    public static func dequeue() -> SimpleHTTPRequest {
        let simpleRequest = requestQueue[0]
        requestQueue.remove(at: 0)
        requestsInProcessing += 1;
        print("Requests in processing: \(requestsInProcessing)")
        return simpleRequest
    }
    
    
    public static func execute(_ status: NSObject.ReachabilityStatus, completionHandler: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> ()) {
        let executionThread = DispatchQueue.global(qos: .background)
        print("Reachability: \(status)")
        executionThread.async {
            /// Wait on processing requests if already busy
            while(isBusyProcessing(status)) {
                
            }
            let simpleRequest = dequeue()
            let urlRequest = setUpURLRequest(withSimpleRequest: simpleRequest)
            let task = URLSession.shared.dataTask(with: urlRequest) { (dat, res, err) in
                print("Finished processing request number: \(requestsInProcessing)")
                requestsInProcessing -= 1;
                completionHandler(res, dat, err)
            }
            task.resume()
        }
    }
    
    private static func setUpURLRequest(withSimpleRequest simpleRequest: SimpleHTTPRequest) -> URLRequest {
        var urlRequest = URLRequest(url: (simpleRequest.url)!)
        urlRequest.httpMethod = simpleRequest.httpMethod.rawValue
        if let data = simpleRequest.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        }
        return urlRequest
    }
    
    private static func isBusyProcessing(_ status: NSObject.ReachabilityStatus) -> Bool {
        switch status {
        case .reachableViaWWAN: return requestsInProcessing >= 2
        case .reachableViaWiFi: return requestsInProcessing >= 6
        case .notReachable: return true
        }
    }

}
