//
//  GitHubAPIUserProfileRepositoriesTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import PromiseKit
import CancellationToken
@testable import GitHubBrowser

class GitHubAPIUserProfileRepositoriesTests: GHUserProfileTestCase {
    
    let repositoriesRoute = "/user/repos"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testRepositoriesFetchingSuccess() {
        
        self.simulateResponseJSON(withFile: "github_repos_fetch_response_200.json", route: repositoriesRoute)
        let expectation = self.expectation(description: "Request expectation.")
        
        firstly {
            profileService.fetchUserRepositories(cancelltaionToken: nil)
        }.then { (repositories: [RepositoryRecord]) -> Void in
            
            XCTAssertEqual(repositories.count, 7, "Invalid repositories count.")
            
            let repository = repositories[2]
            
            XCTAssertEqual(repository.name, "GitHubBrowser", "Invalid repo name.")
            XCTAssertEqual(repository.language, "Objective-C", "Invalid repo language.")
            XCTAssertEqual(repository.starsCount, 0, "Invalid stars count.")
            XCTAssertNil(repository.description, "Invalid repo description.")
            
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testRepositoriesFetchingUnauthorized() {
        
        self.simulateResponseJSON(withFile: "github_fetch_response_401.json", route: repositoriesRoute)
        let expectation = self.expectation(description: "Request expectation.")
        
        firstly {
            profileService.fetchUserRepositories(cancelltaionToken: nil)
        }.then { (repositories: [RepositoryRecord]) -> Void in
            XCTFail("No response must be provided.")
        }.catch { (error) in
            expectation.fulfill()
        }
        
        self.waitForExpectations()
    }
    
    func testRepositoriesFetchingCancellation() {
        
        self.simulateResponseJSON(withFile: "github_repos_fetch_response_200.json", route: repositoriesRoute)
        let expectation = self.expectation(description: "Request expectation.")
        
        let tokenSource = CancellationTokenSource()
        
        firstly {
            profileService.fetchUserRepositories(cancelltaionToken: tokenSource.token)
        }.then { (repositories: [RepositoryRecord]) -> Void in
            XCTFail("No response must be provided.")
        }.catch { error in
            XCTFail("No error must be provided.")
        }.always {
            expectation.fulfill()
        }
        
        tokenSource.cancel()
        
        self.waitForExpectations()
    }
}
