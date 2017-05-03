//
//  GitHubAPIAuthenticationTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import PromiseKit
import CancellationToken
@testable import GitHubBrowser

class GitHubAPIAuthenticationTests: GHTestCase {
    
    let authRoute = "authorizations/clients/"
    let authService = GitHubAuthenticationService()
    let credentials = AuthCredentials(username: "test", password: "test", code: "1234")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginDefaultFlow() {
        
        self.simulateResponseJSON(withFile: "guthub_auth_default_response_200.json", route: authRoute)
        
        // Validate response
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            authService.login(withCredentials: credentials, cancelltaionToken: nil)
        }.then { token -> Void in
            XCTAssertEqual(token, "52fe1f630a4474517c75ead56eaa", "Invalid token.")
        }.catch { error in
            XCTFail("No error must be provided.")
        }.always {
            expectation.fulfill()
        }
        
        self.waitForExpectations()
    }
    
    func testLoginTwoFactorFlowError() {
        
        self.simulateResponse(withFile: "guthub_auth_otp_response_401.json", route: authRoute, code: 401, headers: ["X-GitHub-OTP" : "required; sms"])
        
        // Validate response
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            authService.login(withCredentials: credentials, cancelltaionToken: nil)
        }.then { token -> Void in
            XCTFail("No token must be provided.")
        }.catch { error in
            XCTAssertEqual(error as! AuthenticationServiceError, AuthenticationServiceError.OTPRequired, "Invalid response state.")
        }.always {
            expectation.fulfill()
        }
        
        self.waitForExpectations()
    }
    
    func testLoginBadCredentialsError() {
        
        self.simulateResponse(withFile: "guthub_auth_bad_credentials_response_401.json", route: authRoute, code: 401, headers: nil)
        
        // Validate response
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            authService.login(withCredentials: credentials, cancelltaionToken: nil)
        }.then { token -> Void in
            XCTFail("No token must be provided.")
        }.catch { error in
            XCTAssertEqual(error as! AuthenticationServiceError, AuthenticationServiceError.BadCredentials, "Invalid response state.")
        }.always {
            expectation.fulfill()
        }
        
        self.waitForExpectations()
    }
    
    func testLoginCancellation() {
        
        let tokenSource = CancellationTokenSource()
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            authService.login(withCredentials: credentials, cancelltaionToken: tokenSource.token)
        }.then { token -> Void in
            XCTFail("No token must be provided.")
        }.catch { error in

            XCTAssertTrue(error.isCancelledError, "Invalid error.")
            expectation.fulfill()
        }
        
        tokenSource.cancel()
        
        self.waitForExpectations()
    }
    
}
