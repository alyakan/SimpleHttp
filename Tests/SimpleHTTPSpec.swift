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
    
    var url: URL!
    var simpleRequest: SimpleHTTPRequest?
    
    override func setUp() {
        super.setUp()
        
    }

    override func spec() {
        
        beforeEach {
            self.url = URL(string: "https://www.facebook.com")
            self.simpleRequest = SimpleHTTPRequest(url: self.url, httpVerb: .get, parameters: nil)
        }

        describe("SimpleHTTPSpec") {
            it("works") {
                expect("SimpleHTTP") == "SimpleHTTP"
            }
            
            it("should create SimpleHttpRequest") {
                if let url = self.url {
                    if let _ = SimpleHTTPRequest(url: url, httpVerb: .get, parameters: nil) {
                        expect(true) == true
                    } else {
                        expect(false) == false
                    }
                }
            }
            
            it("should enqueue request") {
                expect(SimpleHTTP.enqueue(request: self.simpleRequest!)).to(equal(true))
            }
        }

    }
    
    func testCreateSimpleHttpRequest() {
        print("Testing createSimpleHttpRequest ...")
        if let url = self.url {
            print("Testing ...")
            let simpleRequest = SimpleHTTPRequest(url: url, httpVerb: .get, parameters: nil)
            XCTAssertNotNil(simpleRequest)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        self.url = nil
    }

}
