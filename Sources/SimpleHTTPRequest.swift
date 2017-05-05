//
//  SimpleHTTPRequest.swift
//  SimpleHTTP
//
//  Created by Aly Yakan on 5/5/17.
//  Copyright © 2017 cookiecutter-swift. All rights reserved.
//

import Foundation

enum HTTPVerb {
    case get
    case post
    case put
    case delete
}

class SimpleHTTPRequest {
    private var url: URL!
    private var httpVerb: HTTPVerb!
    private var parameters: NSDictionary?
    
    init?(url: URL, httpVerb: HTTPVerb, parameters: NSDictionary?) {
        self.url = url
        self.httpVerb = httpVerb
        self.parameters = parameters
    }
}
