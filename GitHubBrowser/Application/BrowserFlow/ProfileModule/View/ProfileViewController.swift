//
//  ProfileViewController.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    var output: ProfileViewOutput?
    
    @IBOutlet weak var userProfileView: UserProfileHeaderView!
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Be ready with tableView custom appearance.
        self.prepareTableViewAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()
    }
    
    // MARK: - State controlls -
    
    fileprivate func activateUnauthorizedState() {
    
        // Disable unneeded controls.
        tableView.isScrollEnabled = false;
        footerView.isHidden = true;
        
        // Reset profile view state.
        userProfileView.resetState();
    }
    
    fileprivate func activateAuthorizedState() {
        tableView.isScrollEnabled = true;
        footerView.isHidden = false;
    }
    
    // MARK: - Appearance Helpers -
    
    fileprivate func prepareTableViewAppearance() {
        
        // Apply insets
        let topInset = UIApplication.shared.statusBarFrame.size.height
        let bottomInset = self.tabBarController?.tabBar.bounds.size.height ?? 0
        
        self.tableView?.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0)
        
        // Activate automatic cell sizing.
        tableView.estimatedRowHeight = RepositoriesDataProvider.CellEstimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - User Input -
    
    @IBAction func onRefreshAction(_ sender: Any) {
        output?.userWantsLatestData()
    }

    @IBAction func onSignOutAction(_ sender: Any) {
        output?.userWantsToSignOut()
    }
}

extension ProfileViewController : ProfileViewProtocol {
    
    func showUnauthorizedState() {

        // Apply unauthorized content.
        tableView.contentProvider = UnauthorizedStateDataProvider(delegate: self);
        
        // Change views state accourding to unauthorized state requirements
        self.activateUnauthorizedState()
    }
    
    func showNoContentState() {
        
        tableView.contentProvider = NoContentStateDataProvider()
        
        // Disable required controlls.
        self.activateAuthorizedState()
    }
    
    func showActivity() {
        refreshControl?.beginRefreshing()
    }
    
    func hideActivity() {
        refreshControl?.endRefreshing()
    }
    
    func showUserProfile(_ profile: UserProfileRecord) {
        userProfileView.setUserAvarar(link: profile.avatarUrl)
        userProfileView.setUserName(profile.userName)
    }
    
    func showRepositories(_ repositories:[RepositoryRecord]?) {
        tableView.contentProvider = RepositoriesDataProvider(repositories: repositories)
    }
    
    func showSignOutAlert() {
        let signOutAlert = UIAlertController.alertControllerForSignOut { [weak self] in
            self?.output?.userDidAcceptSignOut()
        };
        
        self.present(signOutAlert, animated: true, completion: nil)
    }
}

extension ProfileViewController: UnauthorizedStateDataProviderDelegate {
    
    func onSignInAction() {
        output?.userWantsToSignIn()
    }
}
