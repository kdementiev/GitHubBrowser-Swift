//
//  GHRepositoryEntity.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/29/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import ObjectMapper

struct GHRepositoryEntity: Mappable {

    var name: String?
    var description: String?
    
    var language: String?
    var starsCount: Int?
    
    var owner: GHUserEntity?
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        description <- map["description"]
        
        language <- map["language"]
        starsCount <- map["starsCount"]
        
        owner <- map["owner"]
    }
}
