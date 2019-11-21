//
//  Post.swift
//  S.A-Wijethunga-COBSCComp181p-004
//
//  Created by Digital-02 on 11/21/19.
//  Copyright © 2019 Digital-02. All rights reserved.
//

import Foundation

struct AddPostModel: Codable {
    
    var title : String!
    var description : String!
    var user: String!
    var image_url: String!
    
    init(title: String, description: String,user: String,image_url:String) {
        self.title = title
        self.description = description
        self.user=user
        self.image_url=image_url
    }
    
    
    
    
}
