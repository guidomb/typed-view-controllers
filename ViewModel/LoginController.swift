//
//  LoginController.swift
//  ViewModel
//
//  Created by Guido Marucci Blas on 7/12/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

typealias DefaultLoginController = LoginController<LoginView, LoginViewModel>

final class DefaultLoginControllerFactory: ControllerFactory<LoginView, LoginViewModel, LoginController<LoginView, LoginViewModel>> {
    
}

final class LoginController<View: LoginViewType, ViewModel: LoginViewModelType>: BaseController<View, ViewModel> {
    
    override func bindViewModel(with view: View) {
        view.usernameTextField.text = viewModel.username.text
        view.passwordTextField.text = viewModel.password.text
        view.usernameTextField.addTarget(self, action: #selector(usernameChanged), for: .valueChanged)
        view.passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .valueChanged)
        updateView(view: view)
    }
    
    @objc
    private func usernameChanged() {
        guard let typedView = self.typedView, let username = typedView.usernameTextField.text else { return }
        
//        viewModel.username.text = username
        updateView(view: typedView)
    }
    
    @objc
    private func passwordChanged() {
        guard let typedView = self.typedView, let password = typedView.passwordTextField.text else { return }
        
//        viewModel.password.text = password
        updateView(view: typedView)
    }
    
}

private extension LoginController {
    
    private func updateView(view: View) {
        view.loginButton.isEnabled = viewModel.loginEnabled
        view.usernameTextField.borderStyle = .line
        view.usernameTextField.layer.borderColor = viewModel.username.borderColor.cgColor
        view.passwordTextField.borderStyle = .line
        view.passwordTextField.layer.borderColor = viewModel.password.borderColor.cgColor
    }
    
}
