//
//  AuthenticationViewController.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var currentTextField: UITextField!
    
    
    var output: AuthenticationViewOutput?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()
        
        // We need small amount of keyboard state notifications.
        self.subscribeForKeyboardNotifications();
    }
    
    // MARK - NotificationCenter Subscriptions -
    
    fileprivate func subscribeForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: .UIKeyboardDidShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK - Keyboard Events Observing -

    @objc fileprivate func keyboardDidShow(_ notification: Notification) {
        
        guard let rect = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect else {
            return
        }
    
        // Apply content insets accourding to keyboard height.
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0)
        
        var frame = self.view.frame
        frame.size.height -= rect.size.height
        
        if frame.contains(self.currentTextField.frame.origin) {
            self.scrollView.scrollRectToVisible(self.currentTextField.frame, animated: true)
        }
    }
    
    @objc fileprivate func keyboardWillHide() {
        self.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    // MARK: - User Actions -
    
    @IBAction func onTapAction(_ sender: Any) {
        currentTextField.resignFirstResponder()
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        self.notifyWithUserWantsToLogin()
    }
    
    @IBAction func onNoAccountAction(_ sender: Any) {
        output?.userWantsToCreateAccount()
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        output?.userWantsToCancel()
    }
    
    // MARK: - Alert Helpers -
    
    fileprivate func showTwoFactorAuthenticationAlert() {
        
        let alert = UIAlertController.twoFactorAlert { [weak self] (code: String?) in
            self?.output?.userProvidesTwoFactorCode(code)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func showErrorAlert(_ text: String?) {
        let alert = UIAlertController.authErrorAlert(message: text)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Notification Helpers -
    
    fileprivate func notifyWithUserWantsToLogin() {
        // Notify presenter layer with user credentials.
        output?.userWantsToLogin(username: loginTextField.text, password: passwordTextField.text)
    }
}

extension AuthenticationViewController: AuthenticationViewProtocol {
    
    func showActivityState(_ show: Bool) {
        
        self.view.isUserInteractionEnabled = !show
        
        // Prepare activity indicator
        activityIndicator.isHidden = !show
        
        if (show) {
            activityIndicator.startAnimating()
        }
    }
    
    func showInvalidCredentialsMessage() {
        self.showErrorAlert("Invalid credentials. Please try again.".localized())
    }
    
    func showInvalidTwoFactorCodeMessage() {
        self.showErrorAlert("Invalid two-factor code. Please try again.".localized())
    }
    
    func showUserNameError() {
        loginTextField.showError(true)
        self.showErrorAlert("Invalid login.".localized())
    }
    
    func showPasswordError() {
        passwordTextField.showError(true)
        self.showErrorAlert("Invalid passord.".localized())
    }
    
    func showTwoFactorCodeInput() {
        self.showTwoFactorAuthenticationAlert()
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Save current text field.
        currentTextField = textField
        
        // Disable error promt.
        currentTextField.showError(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // User-friendly: move to password input.
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
            return true
        }
        
        currentTextField.showError(false)
        currentTextField.resignFirstResponder()
        
        self.notifyWithUserWantsToLogin()
        
        return true
    }
}
