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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var touchIdButton: UIButton!
    var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUsernameField()
        setupPasswordField()
        setupTouchIdButton()
        setupLoginButton()
    }
    
    func touchIDTapped() {
        
    }
    
    func loginButtonTapped() {
        
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
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
        
    }
}

//MARK: - Setup
fileprivate extension LoginViewController {
    func setupUsernameField() {
        usernameTextField = UITextField()
        usernameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        usernameTextField.placeholder = "Enter Username"
        usernameTextField.borderStyle = .roundedRect
        contentStackView.addArrangedSubview(usernameTextField)
        usernameTextField.leftAnchor.constraint(equalTo: contentStackView.leftAnchor).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo: contentStackView.rightAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupPasswordField() {
        passwordTextField = UITextField()
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.borderStyle = .roundedRect
        contentStackView.addArrangedSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: contentStackView.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: contentStackView.rightAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupTouchIdButton() {
        touchIdButton = UIButton(type: .system)
        touchIdButton.setTitle("TouchID", for: .normal)
        touchIdButton.addTarget(self, action: #selector(touchIDTapped), for: .touchUpInside)
        contentStackView.addArrangedSubview(touchIdButton)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        contentStackView.addArrangedSubview(loginButton)
    }
}
