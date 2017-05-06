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
    var parameters: NSDictionary!
    
    override func setUp() {
        super.setUp()
        self.url = URL(string: self.baseUrl)
        self.simpleRequest = SimpleHTTPRequest(url: self.url, httpMethod: .get, parameters: nil)
        self.parameters = ["name": "paul rudd", "movies": ["I love you man"]]
    }
    
    override func tearDown() {
        self.url = nil
        self.simpleRequest = nil
        self.baseUrl = ""
        self.parameters = nil
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
        let queueCount = SimpleHTTP.queueCount
        SimpleHTTP.enqueue(request: self.simpleRequest!)
        XCTAssertEqual(queueCount + 1, SimpleHTTP.queueCount)
        XCTAssertNotNil(SimpleHTTP.dequeue())
    }
    
    func testShouldExecuteGetRequest() {
        let url = self.url.appendingPathComponent("/users?page=2")
        let exp = expectation(description: "should execute get request with status code 200")
        if let request = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: self.parameters) {
            SimpleHTTP.enqueue(request: request)
            SimpleHTTP.execute(currentReachabilityStatus, completionHandler: { (response, data, error) in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 200 && response.statusCode < 400 {
                        exp.fulfill()
                    } else {
                        XCTFail()
                    }
                }
            })
            waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
    func testShouldExecutePostRequest() {
        let url = self.url.appendingPathComponent("/users")
        let exp = expectation(description: "should execute post request")
        if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .post, parameters: self.parameters) {
            SimpleHTTP.enqueue(request: simpleRequest)
            SimpleHTTP.execute(currentReachabilityStatus, completionHandler: { (response, data, error) in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 200 && response.statusCode < 400 {
                        exp.fulfill()
                    } else {
                        XCTFail()
                    }
                }
            })
            waitForExpectations(timeout: 10, handler: nil)
            
        }
    }
    
    func testShouldExecutePutRequest() {
        let url = self.url.appendingPathComponent("/users/1")
        let exp = expectation(description: "should execute put request")
        if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .put, parameters: self.parameters) {
            SimpleHTTP.enqueue(request: simpleRequest)
            SimpleHTTP.execute(currentReachabilityStatus, completionHandler: { (response, data, error) in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 200 && response.statusCode < 400 {
                        exp.fulfill()
                    } else {
                        XCTFail()
                    }
                }
            })
            waitForExpectations(timeout: 10, handler: nil)
            
        }
    }
    
}
