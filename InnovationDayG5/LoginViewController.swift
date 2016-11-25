//
//  LoginViewController.swift
//  InnovationDayG5
//
//  Created by James Pang on 24/11/2016.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var touchIdButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            let bgImg = UIImage.withColor(UIColor(red: 1, green: 102/255, blue: 51/255, alpha: 1))
            loginButton.setBackgroundImage(bgImg, for: .normal)
            loginButton.layer.cornerRadius = 6.0
            
        }
    }
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUsernameField()
        setupPasswordField()
    }
    
    @IBAction func touchIdButtonTapped(_ sender: AnyObject) {
        let authenticationContext = LAContext()
        
        var error: NSError?
        
        //Check if the device has a fingerpprint sensor
        //If not, show the user an alert view and bail out
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            showError(message: error?.localizedDescription ?? "Sorry, cannot perform touch ID")
            return
        }
        
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login via touch ID") {
            success, error in
            
            DispatchQueue.main.async {
                
                if success {
                    self.pushMainViewController()
                } else {
                    self.showError(message: error?.localizedDescription ?? "")
                }
            }
        }
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        guard viewModel.canLogin else {
            showError(message: "Please enter a username or password")
            return
        }
        
        pushMainViewController()
    }
    
    
    func textFieldChanged(textField: UITextField) {
        if textField == usernameTextField {
            viewModel.username = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
}

//MARK: - Private
fileprivate extension LoginViewController {
    
    func pushMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}

//MARK: - Setup
fileprivate extension LoginViewController {
    func setupUsernameField() {
        usernameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    func setupPasswordField() {
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
}
