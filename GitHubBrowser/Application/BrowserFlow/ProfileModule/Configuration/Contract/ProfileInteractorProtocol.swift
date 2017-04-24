//
//  ProfileInteractorProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol ProfileInteractorOutput: class {

    func userAuthorized()
    func userNotAuthorized()
    
    func userProfileReveived(_ profile: UserProfileRecord)
    func userRepositoriesReceived(_ repositories:[RepositoryRecord]?)

}

protocol ProfileInteractorProtocol: class {
    weak var output: ProfileInteractorOutput? { get set }
    
    /**
        Method offered to perform initial preparations inside interactor.
     */
    func prepare()
    
    /**
        Offers ability to request data fetching.
     */
    func fetchData()
    
    /**
        Immeadiatly performs sign-out for current user.
     */
    func performSignOut()
}
