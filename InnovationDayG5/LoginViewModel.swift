//
//  LoginViewModel.swift
//  InnovationDayG5
//
//  Created by James Pang on 24/11/2016.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import Foundation

class LoginViewModel {
    var username = "" {
        didSet {
            print(username)
        }
    }
    var password = "" {
        didSet {
            print(password)
        }
    }
}

//MARK: - Public
extension LoginViewModel {
    var canLogin: Bool {
        return username.characters.count > 0 && password.characters.count > 0
    }
}
