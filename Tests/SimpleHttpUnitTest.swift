//
//  SimpleHttpUnitTest.swift
//  SimpleHTTP
//
//  Created by Aly Yakan on 5/5/17.
//  Copyright © 2017 cookiecutter-swift. All rights reserved.
//

import XCTest
@testable import SimpleHTTP

class SimpleHttpUnitTest: XCTestCase {
    
    var baseUrl: String = "https://ta.dreidev.com/api"
    var url: URL!
    var simpleRequest: SimpleHTTPRequest?
    
    override func setUp() {
        super.setUp()
        self.url = URL(string: self.baseUrl)
        self.simpleRequest = SimpleHTTPRequest(url: self.url, httpMethod: .get, parameters: nil)
    }
    
    override func tearDown() {
        self.url = nil
        self.simpleRequest = nil
        self.baseUrl = ""
        super.tearDown()
    }
    
    func testShouldCreateSimpleHttpRequest() {
        if let url = self.url {
            if let _ = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: nil) {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
        }
    }
    
    func testShouldEnqueueRequest() {
        XCTAssertTrue(SimpleHTTP.enqueue(request: self.simpleRequest!))
    }
    
    func testShouldExecuteRequest() {
        let url = self.url.appendingPathComponent("/jobs/1")
        let exp = expectation(description: "Execute request")
        if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: nil) {
            if SimpleHTTP.enqueue(request: simpleRequest) {
                measure {
                    SimpleHTTP.execute(completionHandler: { (response, data, error) in
                        if let data = data {
                            let json = try? JSONSerialization.jsonObject(with: data, options: [])
                            if let _ = json as? [String: Any] {
                                exp.fulfill()
                            } else {
                                XCTFail()
                            }
                        }
                    })
                }
            }
            waitForExpectations(timeout: 10, handler: nil)
            
        }
    }
    
}
