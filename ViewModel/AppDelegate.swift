//
//  AppDelegate.swift
//  ViewModel
//
//  Created by Guido Marucci Blas on 7/11/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let viewModel = LoginViewModel()
        let controller = DefaultLoginController(viewModel: viewModel)
        window?.rootViewController = controller
        
        return true
    }

}

