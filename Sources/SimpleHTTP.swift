//
//  SimpleHTTP.swift
//  SimpleHTTP
//
//  Created by Aly Yakan on 5/5/17.
//  Copyright © 2017 cookiecutter-swift. All rights reserved.
//

import Foundation

struct SimpleHTTP {
    private init() {
//        print(NSObject.currentReachabilityStatus)
    }
    
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
    
    /**
     It dequeues the first request in the request queue.
     
     - Returns: A SimpleHttpRequest Object.
     */
    public static func dequeue() -> SimpleHTTPRequest {
        let simpleRequest = requestQueue.first
        requestQueue.remove(at: 0)
        requestsInProcessing += 1;
        print("Requests in processing: \(requestsInProcessing)")
        return simpleRequest!
    }
    
    
    public static func execute(_ status: NSObject.ReachabilityStatus, completionHandler: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> ()) {
        let executionThread = DispatchQueue.global(qos: .background)
        print("Reachability: \(status)")
        if requestsInProcessing > 2 {
            
        }
        executionThread.async {
            while(requestsInProcessing > 2) {
                
            }
            let simpleRequest = dequeue()
            var urlRequest = URLRequest(url: (simpleRequest.url)!)
            urlRequest.httpMethod = simpleRequest.httpMethod.rawValue
            //            urlRequest.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            //            urlRequest.setValue("gzip;q=0,deflate,sdch", forHTTPHeaderField: "accept-encoding")
            //            urlRequest.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: urlRequest) { (dat, res, err) in
                print("Finished processing request number: \(requestsInProcessing)")
                requestsInProcessing -= 1;
                completionHandler(res, dat, err)
            }
            task.resume()
        }
    }

}
