//
//  GitHubAPISearchTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import PromiseKit
import CancellationToken
@testable import GitHubBrowser

class GitHubAPISearchTests: GHTestCase {
    
    let searchService = GitHubSearchService()
    let searchRoute = "/search/repositories?q=test"
    let searchQuery = "GitHubBrowser"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSearchSuccess() {
        
        self.simulateResponseJSON(withFile: "github_search_response_200.json", route: searchRoute)
        
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            searchService.searchRepositories(withText: "test", cancelltaionToken: nil)
        }.then { (repositories: [RepositoryRecord]) -> Void in
            
            XCTAssertEqual(repositories.count, 2, "Invalid repositories count")
            
            guard let repository = repositories.first else {
                XCTFail("Invalid response.")
                return
            }
            
            XCTAssertEqual(repository.name, "GithubBrowser", "Invalid repository name")
            XCTAssertEqual(repository.description, "A Github Browser For iPad", "Invalid repository description")
            XCTAssertEqual(repository.starsCount, 28, "Invalid repository stars count")
            
            expectation.fulfill()
            
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testSearchNotFound() {
        
        self.simulateResponseJSON(withFile: "github_search_notfound_response_200.json", route: searchRoute)
        
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            searchService.searchRepositories(withText: "", cancelltaionToken: nil)
        }.then { (repositories: [RepositoryRecord]) -> Void in
            
            XCTAssertEqual(repositories.count, 0, "Invalid repositories count")
            
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testSearchValidationFailed() {
        
        self.simulateResponseJSON(withFile: "github_search_invalid_response_422.json", route: searchRoute, code: 422)
        
        let expectation = self.expectation(description: "Waiting for response.")
        
        firstly {
            searchService.searchRepositories(withText: "", cancelltaionToken: nil)
        }.then { (repositories: [RepositoryRecord]) -> Void in
                
            XCTAssertEqual(repositories.count, 0, "Invalid repositories count")
                
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()
    }
    
    func testSearchCancelation() {
        
        let tokenSource = CancellationTokenSource()
        let expectation = self.expectation(description: "Waiting for response.")
        
        self.simulateResponseJSON(withFile: "github_search_response_200.json", route: searchRoute)
        
        firstly {
            searchService.searchRepositories(withText: searchQuery, cancelltaionToken: tokenSource.token)
        }.then { (repositories: [RepositoryRecord]) -> Void in
            XCTFail("No response must be provided.")
        }.catch { error in
            XCTFail("No error must be provided.")
        }.always {
            expectation.fulfill()
        }
        
        // Cancel async task.
        tokenSource.cancel()
        
        self.waitForExpectations()
    }
}
