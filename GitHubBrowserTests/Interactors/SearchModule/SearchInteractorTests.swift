//
//  SearchInteractorTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/4/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
@testable import GitHubBrowser

class SearchInteractorTests: GHTestCase {
    
    var mockSearchNetworking = MockSearchNetworkingService()
    var mockHistoryStorage = MockLocalStorageService()
    
    var interactor = SearchInteractor()
    
    override func setUp() {
        super.setUp()
        
        // Prepare interactor with mocks.
        interactor.searchNetworking = mockSearchNetworking
        interactor.historyStorage = mockHistoryStorage
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchHistoryOperation() {
        
        // Prepare mocks.
        mockHistoryStorage.saveSearchQuery("GitHubBrowser1")
        mockHistoryStorage.saveSearchQuery("GitHubBrowser2")
        
        let expectation = self.expectation(description: "Wait for result.")
        
        interactor.output = MockSearchInteractorOutput(history: { (list) in
            
            XCTAssertEqual(list.count, 2, "Invalid response objects count.")
        
            guard let repository = list.first else {
                XCTFail("No repository provided.")
                return
            }
        
            XCTAssertEqual(repository.query, "GitHubBrowser1", "Invalid response object.")
    
            expectation.fulfill()
        }, search: nil)
        
        // Let's try to fetch.
        interactor.fetchSearchHistory()
        
        self.waitForExpectations()
    }
    
    func testSearchOperation() {
        
        let expectation = self.expectation(description: "Wait for result.")
        
        // Initialize result.
        mockSearchNetworking.result = RepositoryRecord(ownerName: "me", name: "GitHubBrowser", description: "Sample App", language: "Swift", starsCount: 1)
        
        interactor.output = MockSearchInteractorOutput(history: nil, search: { repositories in
            
            XCTAssertEqual(repositories.count, 1, "Invalid response objects count.")
            
            guard let repository = repositories.first else {
                XCTFail("No repository provided.")
                return
            }
            
            XCTAssertEqual(repository.name, "GitHubBrowser")
            
            expectation.fulfill()
        })
        
        // Let's try to fetch.
        interactor.searchRepositories(text: "GitHubBrowser")
        
        self.waitForExpectations()
        
    }
    
    func testSearchOperationCancellation() {
        
        interactor.output = MockSearchInteractorOutput(history: nil, search: { repositories in
            XCTFail("No result must be provided.")
        })
        
        interactor.searchRepositories(text: "GitHubBrowser")
        interactor.cancelSearch()
    
        sleep(3)
    }
}
