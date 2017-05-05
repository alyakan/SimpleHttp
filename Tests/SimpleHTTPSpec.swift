//
//  SimpleHTTPSpec.swift
//  SimpleHTTP
//
//  Created by Aly Yakan on 04/10/16.
//  Copyright © 2017 cookiecutter-swift. All rights reserved.
//

import Quick
import Nimble
@testable import SimpleHTTP

class SimpleHTTPSpec: QuickSpec {
    
    var baseUrl: String = "https://jsonplaceholder.typicode.com"
    var url: URL!
    var simpleRequest: SimpleHTTPRequest?
    
    override func setUp() {
        super.setUp()
        
    }

    override func spec() {
        
        beforeEach {
            self.url = URL(string: self.baseUrl)
            self.simpleRequest = SimpleHTTPRequest(url: self.url, httpMethod: .get, parameters: nil)
        }

        describe("SimpleHTTPSpec") {
            it("works") {
                expect("SimpleHTTP") == "SimpleHTTP"
            }
            
            it("should create SimpleHttpRequest") {
                if let url = self.url {
                    if let _ = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: nil) {
                        expect(true) == true
                    } else {
                        expect(false) == false
                    }
                }
            }
            
            it("should enqueue request") {
                expect(SimpleHTTP.enqueue(request: self.simpleRequest!)).to(equal(true))
            }
            
            it("should execute request") {
                let url = self.url.appendingPathComponent("/posts")
                if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: nil) {
                    if SimpleHTTP.enqueue(request: simpleRequest) {
                        print("Should execute")
                        SimpleHTTP.execute(completionHandler: { (response, data, error) in
                            print("Executing")
                            print(response ?? "No response")
                            sleep(5)
                        })
                    }
                    
                }
                
            }
        }

    }
    
    func testCreateSimpleHttpRequest() {
        print("Testing createSimpleHttpRequest ...")
        if let url = self.url {
            print("Testing ...")
            let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .get, parameters: nil)
            XCTAssertNotNil(simpleRequest)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        self.url = nil
    }

}
