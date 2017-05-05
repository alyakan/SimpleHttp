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
        return simpleRequest!
    }
    
    public static func execute(completionHandler: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> ()) {
        let simpleRequest = dequeue()
        var urlRequest = URLRequest(url: (simpleRequest.url)!)
        print("SimpleHttp.execute")
        urlRequest.httpMethod = simpleRequest.httpMethod.rawValue
        DispatchQueue.global(qos: .background).async {
            print("SimpleHttp.execute.background")
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: OperationQueue.main) { (res, dat, err) in
                completionHandler(res, dat, err)
            }
        }
        
    }
}
