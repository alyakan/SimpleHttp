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
    
    var baseUrl: String = "https://reqres.in/api"
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
        XCTAssertNotNil(SimpleHTTP.dequeue())
    }
    
    func testShouldExecuteGetRequest() {
        let url = self.url.appendingPathComponent("/users?page=2")
        let exp = expectation(description: "should execute get request with status code 200")
        if let request = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: ["Body": "Okay"]) {
            if SimpleHTTP.enqueue(request: request) {
                SimpleHTTP.execute(currentReachabilityStatus, completionHandler: { (response, data, error) in
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode >= 200 && response.statusCode < 400 {
                            exp.fulfill()
                        } else {
                            XCTFail()
                        }
                    }
                })
                
            }
            waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
    func testShouldExecutePostRequest() {
        let url = self.url.appendingPathComponent("/users")
        let exp = expectation(description: "should execute post request")
        if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .post, parameters: ["name": "paul rudd", "movies": ["I love you man"]]) {
            if SimpleHTTP.enqueue(request: simpleRequest) {
                SimpleHTTP.execute(currentReachabilityStatus, completionHandler: { (response, data, error) in
                    print("Response: ", response ?? "No response")
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode >= 200 && response.statusCode < 400 {
                            exp.fulfill()
                        } else {
                            XCTFail()
                        }
                    }
                })
                
            }
            waitForExpectations(timeout: 10, handler: nil)
            
        }
    }
    
}
