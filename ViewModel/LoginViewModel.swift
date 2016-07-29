//
//  LoginViewModel.swift
//  ViewModel
//
//  Created by Guido Marucci Blas on 7/12/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

protocol LoginViewModelType: ViewModelType {
    
    var username: ValidableTextField { get }
    var password: ValidableTextField { get }
    var loginEnabled: Bool { get }
    
    func login(callback: (NSError?) -> ())
    
}

final class LoginViewModel: LoginViewModelType {
    
    var username = ValidableTextField(validator: { !$0.isEmpty })
    var password = ValidableTextField(validator: { $0.characters.count > 4 })
    var loginEnabled: Bool { return username.isValid && password.isValid }
    
    func login(callback: (NSError?) -> ()) {
        print("Logging in user '\(username.text)' with password '\(password.text)'")
        callback(.none)
    }
    
}
