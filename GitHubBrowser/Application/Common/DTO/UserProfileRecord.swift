//
//  UserProfileRecord.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

struct UserProfileRecord {
    
    var userName: String?
    var avatarUrl: String?
    
    var publicRepositoriesCount: NSInteger
    var followersCount: NSInteger
    var followingCount: NSInteger
}
