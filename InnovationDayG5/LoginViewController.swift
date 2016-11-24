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
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUsernameField()
        setupPasswordField()
    }
    
    @IBAction func touchIdButtonTapped(_ sender: AnyObject) {
        
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
        //Carlo enter code here
        
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
