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
    
    public static func enqueue(request: SimpleHTTPRequest) -> Bool {
        let previousCount = requestQueue.count
        requestQueue.append(request)
        return requestQueue.count == previousCount + 1
    }
}
