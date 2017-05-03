//
//  GitHubAPIAuthenticationTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
@testable import GitHubBrowser

class GitHubAPIAuthenticationTests: XCTestCase {
    
    let authService = GitHubAuthenticationService()
    let credentials = AuthCredentials(username: "test", password: "test", code: "1234")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginTwoFactorFlow() {
        
    }
    
}
