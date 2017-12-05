//
//  AppDelegate.swift
//  CountryPhoneNumberValidator
//
//  Created by moderateepheezy on 12/05/2017.
//  Copyright (c) 2017 moderateepheezy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        return true
    }


}

