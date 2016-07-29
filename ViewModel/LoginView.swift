//
//  LoginView.swift
//  ViewModel
//
//  Created by Guido Marucci Blas on 7/11/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

protocol LoginViewType: ViewType, NibViewLoader {
    
    var usernameTextField: UITextField { get }
    var passwordTextField: UITextField { get }
    var loginButton: UIButton { get }
    
}

final class LoginView: UIView {
    
    @IBOutlet private weak var _usernameTextField: UITextField!
    @IBOutlet private weak var _passwordTextField: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
}

extension LoginView: LoginViewType {
    
    var usernameTextField: UITextField { return _usernameTextField }
    var passwordTextField: UITextField { return _passwordTextField }
    var loginButton: UIButton { return _loginButton }
    
}
