//
//  LocalStorageTests.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest
import PromiseKit
@testable import GitHubBrowser

class LocalStorageTests: GHTestCase {
    
    let localStorage = LocalStorageService()
    let mockQuery = "LocalStorageTests-FutureKit"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQuerySave() {
    
        localStorage.saveSearchQuery(mockQuery)
        
        let expectation = self.expectation(description: "Fetch expectation.")
        firstly {
            localStorage.fetchSearchQueries()
        }.then { (queries: [SearchQueryRecord]) -> Void in
            
            let result = queries.contains(where: { (query: SearchQueryRecord) -> Bool in
                return query.query == self.mockQuery
            })
            
            XCTAssertTrue(result, "Saved Query must be fetched.")
            
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }.always {
            
            // Remove saved query
            self.localStorage.removeQuery(self.mockQuery)
        }
        
        self.waitForExpectations()
    }
    
    func testQueryRemove() {
        
        // Save mock query.
        localStorage.saveSearchQuery(mockQuery)
        
        // Now remove query.
        self.localStorage.removeQuery(mockQuery)
        
        // Validate content inside storage.
        let expectation = self.expectation(description: "Fetch expectation.")
        firstly {
            localStorage.fetchSearchQueries()
        }.then { (queries: [SearchQueryRecord]) -> Void in
                
            let result = queries.contains(where: { (query: SearchQueryRecord) -> Bool in
                return query.query == self.mockQuery
            })
                
            XCTAssertFalse(result, "No mock query must be in storage.")
                
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("No error must be provided.")
        }
        
        self.waitForExpectations()

        
    }
}
