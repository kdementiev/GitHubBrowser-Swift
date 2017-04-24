//
//  UserProfileHeaderView.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit
import SDWebImage


class UserProfileHeaderView: UIView {
    
    private struct AnimationConstants {
        static let duration = 1.0
        static let delay = 0.2
    }

    @IBOutlet weak var imageView: PureImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setUserAvarar(link: String!) {
        
        let avatarURL = URL(string: link)
        imageView.sd_setImage(with: avatarURL) { (image: UIImage?, error: Error?, type: SDImageCacheType, url:URL?) in
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.imageView.alpha = 0.5
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.imageView.alpha = 1.0
            })

        }
    }
    
    func setUserName(_ name: String?) {
        self.nameLabel.text = name
    }
    
    func resetState() {
        self.setUserName(nil)
        imageView.image = nil
    }
}

