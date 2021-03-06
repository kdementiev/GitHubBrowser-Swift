//
//  ProfileInteractor.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation
import PromiseKit
import CancellationToken

class ProfileInteractor {
    
    fileprivate enum State {
        case NotPrepared
        case Authorized
        case Unauthorized
    }
    
    fileprivate var state: State = .NotPrepared
    
    fileprivate lazy var profileTokenSource: CancellationTokenSource? = CancellationTokenSource()
    
    var output: ProfileInteractorOutput?
    
    var tokenStorage: TokenStorageServiceProtocol?
    var profileNetworking: ProfileNetworkingServiceProtocol?
    
    
    fileprivate func processWithUnauthorizedState() {
        state = .Unauthorized
        output?.userNotAuthorized()
    }
    
    fileprivate func processWithAuthorizedState() {
        state = .Authorized
        output?.userAuthorized()
    }
    
    fileprivate func unauthorizeUser() {
        
        // Remove saved token.
        tokenStorage?.removeTokenFromSecureStorage()
        
        self.processWithUnauthorizedState()
    }
    
    fileprivate func cancelTasks() {
        profileTokenSource?.cancel()
        profileTokenSource = nil
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    // MARK: - Interactor Controlls -
    
    func prepare() {
        
        if (state == .Authorized) {
            return;
        }
  
        // Chek if we have token in our storage
        tokenStorage?.fetchTokenFromSecureStorage().then { token -> Void in
    
            // Move to Authorized state.
            self.processWithAuthorizedState()
            
            // Prepare networking service with token.
            self.profileNetworking?.prepare(withToken: token)
            
            // Try to fetch data with new token.
            self.fetchData()
            
        }.catch { error in
            self.processWithUnauthorizedState()
        }
        
    }
    
    func fetchData() {
    
        self.cancelTasks()
        
        // Run 2 async tasks
        profileNetworking?.fetchUserRepositories(cancelltaionToken: profileTokenSource?.token).then { repositiries -> Void in
            self.output?.userRepositoriesReceived(repositiries)
        }.catch { error in
            self.unauthorizeUser()
        }
        
        profileNetworking?.fetchUserProfile(cancelltaionToken: profileTokenSource?.token).then { profile -> Void in
            self.output?.userProfileReveived(profile)
        }.catch { error in
            self.unauthorizeUser()
        }
    }
    
    func performSignOut() {
        self.unauthorizeUser()
    }
}
