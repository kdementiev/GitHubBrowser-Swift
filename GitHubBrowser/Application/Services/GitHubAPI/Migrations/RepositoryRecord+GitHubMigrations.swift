//
//  RepositoryRecord+GitHubMigrations.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/5/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

extension RepositoryRecord {
    
    init(repositoryEntity: GHRepositoryEntity) {
        
        ownerName = repositoryEntity.owner?.login
        name = repositoryEntity.name
        
        description = repositoryEntity.description
        language = repositoryEntity.language
        
        starsCount = repositoryEntity.starsCount ?? 0
    }
}
