//
//  GHTestCase.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import OHHTTPStubs

class GHTestCase: XCTestCase {
    
    private static let ExpectationsTimeout = 3.0

    override func tearDown() {
        self.clearSimulations()
        super.tearDown()
    }
    
    func simulateResponseJSON(withFile name: String, route: String) {
        self.simulateResponse(withFile: name, route: route, code: 200, headers: nil)
    }
    
    func simulateResponseJSON(withFile name: String, route: String, code: Int32) {
        self.simulateResponse(withFile: name, route: route, code: code, headers: nil)
    }
    
    func simulateResponse(withFile name: String, route: String, code: Int32, headers: [AnyHashable : Any]?) {
        
        let requiredHeaders = NSMutableDictionary()
        requiredHeaders.setValue("application/json", forKey: "Content-Type")
    
        if headers != nil {
            requiredHeaders.addEntries(from: headers!)
        }
        
        stub(condition:isPath(route), response: { (request: URLRequest) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(fileAtPath: OHPathForFile(name, GHTestCase.self)!, statusCode: code, headers: requiredHeaders as? [AnyHashable : Any])
        })
    }
    
    func clearSimulations() {
        OHHTTPStubs.removeAllStubs()
    }
    
    func waitForExpectations() {
        self.waitForExpectations(timeout: GHTestCase.ExpectationsTimeout, handler: nil)
    }

}
