//
//  GHUserProfileTestCase.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/3/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import XCTest

@testable import GitHubBrowser

class GHUserProfileTestCase: GHTestCase {
    
    let token = "TestToken"
    
    let profileService = GitHubUserProfileService()
    
    override func setUp() {
        super.setUp()
        
        profileService.prepare(withToken: token)
    }
}
