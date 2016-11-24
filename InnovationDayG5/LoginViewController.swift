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
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUsernameField()
        setupPasswordField()
        setupLoginButton()
    }
    
    func loginButtonTapped() {
        
        guard viewModel.canLogin else { return }
        
        //Push next screen here
        
    }
    
    func textFieldChanged(textField: UITextField) {
        if textField == usernameTextField {
            viewModel.username = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
}

//MARK: - Setup
fileprivate extension LoginViewController {
    func setupUsernameField() {
        usernameTextField = UITextField()
        usernameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        usernameTextField.placeholder = "Enter Username"
        contentStackView.addArrangedSubview(usernameTextField)
    }
    
    func setupPasswordField() {
        passwordTextField = UITextField()
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.placeholder = "Enter Password"
        contentStackView.addArrangedSubview(passwordTextField)
    }
    
    func setupLoginButton() {
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}
