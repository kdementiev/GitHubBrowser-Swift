//
//  GitHubAPIUserProfileFetchingTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import PromiseKit
import CancellationToken
@testable import GitHubBrowser

class GitHubAPIUserProfileFetchingTests: GHUserProfileTestCase {
    
    var profileRoute = "/user"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testTokenIntegration() {
        
        let expectation = self.expectation(description: "Response expectation.")
        self.simulateResponseJSON(withFile: "github_profile_fetch_response_200.json", route: profileRoute)
        
        profileService.fetchUserProfile(cancelltaionToken: nil).then { profile -> Void in
            expectation.fulfill()
        }.catch { error in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testUserProfileFetchingSuccess() {
        
        let expectation = self.expectation(description: "Response expectation.")
        self.simulateResponseJSON(withFile: "github_profile_fetch_response_200.json", route: profileRoute)
        
        firstly {
            profileService.fetchUserProfile(cancelltaionToken: nil)
        }.then { (profile: UserProfileRecord) -> Void in
            
            XCTAssertEqual(profile.userName, "kdementiev", "Incorrect user name.")
            XCTAssertEqual(profile.publicRepositoriesCount, 7, "Incorrect repositories count.")
            XCTAssertEqual(profile.avatarUrl, "https://avatars2.githubusercontent.com/u/15383282?v=3", "Incorrect avatar url.")
            
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testUserProfileFetchingUnauthorized() {
        
        let expectation = self.expectation(description: "Response expectation.")
        self.simulateResponseJSON(withFile: "github_fetch_response_401.json", route: profileRoute, code: 401)
        
        firstly {
            profileService.fetchUserProfile(cancelltaionToken: nil)
        }.then { (profile: UserProfileRecord) -> Void in
            XCTFail("No result must be provided.")
        }.catch { (error) in
            expectation.fulfill()
        }
        
        self.waitForExpectations()
    }
    
    func testUserProfileFetchingCancellation() {
        
        let expectation = self.expectation(description: "Response expectation.")
        self.simulateResponseJSON(withFile: "github_profile_fetch_response_200.json", route: profileRoute)
        
        let tokenSoure = CancellationTokenSource()
        
        profileService.fetchUserProfile(cancelltaionToken: tokenSoure.token).then { (profile) -> Void in
            XCTFail("No result must be provided.")
        }.catch { error in
            XCTFail("No error must be provided.")
        }.always {
            expectation.fulfill()
        }
        
        tokenSoure.cancel()
        
        self.waitForExpectations()
    }
    
}
