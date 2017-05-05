
//
//  UserProfileRecord+GitHubMigrations.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/5/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

extension UserProfileRecord {
    
    init(userEntity: GHUserEntity) {
    
        userName = userEntity.login
        avatarUrl = userEntity.avatarUrl
        
        publicRepositoriesCount = userEntity.repositories ?? 0
        
        followersCount = userEntity.followers ?? 0
        followingCount = userEntity.following ?? 0
    }
}
