//
//  ProfileViewProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol ProfileViewOutput: class {
    
    /**
        Called when view loaded and ready for data.
    */
    func viewReadyForInteraction()
    
    func userWantsToSignIn()
    func userWantsToSignOut()
    func userDidAcceptSignOut()
    
    func userWantsLatestData()
}

protocol ProfileViewProtocol: class {
    var output: ProfileViewOutput? { get set }
    
    func showUnauthorizedState()
    func showNoContentState()
    
    func showActivity()
    func hideActivity()
    
    func showUserProfile(_ profile: UserProfileRecord)
    func showRepositories(_ repositories:[RepositoryRecord]?)
    
    func showSignOutAlert()
}
