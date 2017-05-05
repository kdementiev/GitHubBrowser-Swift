//
//  GHPageEntity+Migrations.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/5/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation


extension GHPageEntity {
    
    func repositoryRecordsList() -> [RepositoryRecord] {
        
        // Try to map data.
        var repositories = [RepositoryRecord]()
        
        if let items = self.items as? [GHRepositoryEntity] {
            for (_, repository) in items.enumerated() {
                let record = RepositoryRecord(repositoryEntity: repository)
                repositories.append(record)
            }
        }
        
        return repositories
    }
}
