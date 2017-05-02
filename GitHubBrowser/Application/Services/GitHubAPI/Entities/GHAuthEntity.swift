//
//  GHAuthEntity.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/29/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import ObjectMapper

struct GHAuthEntity: Mappable {
    
    var id: Int?
    
    var token: String?
    var hashedToken: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        
        token <- map["token"]
        hashedToken <- map["hashed_token"]
    }
}
