//
//  LoginViewController.swift
//  InnovationDayG5
//
//  Created by James Pang on 24/11/2016.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUsernameField()
        setupPasswordField()
        setupLoginButton()
    }
    
    func loginButtonTapped() {
    
    }
}

//MARK: - Setup
fileprivate extension LoginViewController {
    func setupUsernameField() {
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Enter Username"
        contentStackView.addArrangedSubview(usernameTextField)
    }
    
    func setupPasswordField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Enter Password"
        contentStackView.addArrangedSubview(passwordTextField)
    }
    
    func setupLoginButton() {
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}
