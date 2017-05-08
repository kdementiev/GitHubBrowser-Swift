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
        imageView.sd_setImage(with: avatarURL) { [weak self] (image: UIImage?, error: Error?, type: SDImageCacheType, url:URL?) in
            if let image = image {
                self?.applyAvatar(image: image)
            }
        }
    }
    
    func setUserName(_ name: String?) {
        self.nameLabel.text = name
    }
    
    func resetState() {
        self.setUserName(nil)
        imageView.image = nil
    }
    
    private func applyAvatar(image: UIImage) {
        
        UIView.animateKeyframes(withDuration: AnimationConstants.duration, delay: AnimationConstants.delay, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.imageView.alpha = 0.5
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.imageView.alpha = 1.0
            })
            
        }, completion: nil)
    }
}

