//
//  SimpleHTTPRequest.swift
//  SimpleHTTP
//
//  Created by Aly Yakan on 5/5/17.
//  Copyright © 2017 cookiecutter-swift. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POSt"
    case put = "PUT"
    case delete = "DELETE"
}

public class SimpleHTTPRequest {
    public private(set) var url: URL!
    public private(set) var httpMethod: HTTPMethod!
    public private(set) var parameters: NSDictionary?
    public private(set) var headers: Dictionary<String, String>?
    
    public init() {}
    
    public init?(url: URL, httpMethod: HTTPMethod, parameters: NSDictionary? = nil, headers: Dictionary<String, String>? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
    }
}
