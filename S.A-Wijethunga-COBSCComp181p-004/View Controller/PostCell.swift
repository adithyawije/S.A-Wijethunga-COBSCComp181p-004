//
//  PostCell.swift
//  S.A-Wijethunga-COBSCComp181p-004
//
//  Created by Isuru Devinda on 11/22/2562 BE.
//  Copyright © 2562 BE Digital-02. All rights reserved.
//

import UIKit
import Nuke

class PostCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionPost: UILabel!
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func populateData(post: AddPostModel)  {
        
        postTitle.text = post.title
        descriptionPost.text = post.description
        userName.text = post.user
        
        let imgUrl = URL(string: post.image_url)
        
        Nuke.loadImage(with: imgUrl!, into: postImage)
        
    }
    
}
