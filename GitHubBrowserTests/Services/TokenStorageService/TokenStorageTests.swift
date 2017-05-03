//
//  TokenStorageTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import PromiseKit
@testable import GitHubBrowser

class TokenStorageTests: GHTestCase {
    
    let secureStorage = SecureStorageService.sharedInstance
    let token = "dgag3243f439g534g4"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTokenSave() {

        // Try to save token.
        self.secureStorage.saveTokenToSecureStorage(self.token)

        // Start validating storage.
        let expectation = self.expectation(description: "Fetch token expectation.")
        
        firstly {
            secureStorage.fetchTokenFromSecureStorage()
        }.then { token -> Void in
            XCTAssertEqual(token, self.token, "Incorrect token.")
        }.always {
            expectation.fulfill()
        }.catch { error -> Void in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testTokenRemove() {
    
        let expectation = self.expectation(description: "Fetch token expectation.")
        
        self.secureStorage.saveTokenToSecureStorage(self.token)
        
        firstly {
            secureStorage.fetchTokenFromSecureStorage()
        }.then { token ->Void in
            self.secureStorage.removeTokenFromSecureStorage()
        }.catch { error in
            XCTFail("No error must be provided.")
        }.then {
            self.secureStorage.fetchTokenFromSecureStorage()
        }.then { token -> Void in
            XCTFail("Token must be removed.")
        }.catch { error -> Void in
            XCTAssertEqual(error as! TokenStorageServiceError, TokenStorageServiceError.NoTokenFound, "NotFound error must be provided.")
            expectation.fulfill()
        }
        
        self.waitForExpectations()
    }
    
}
