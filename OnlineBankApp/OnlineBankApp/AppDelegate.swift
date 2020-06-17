//
//  AppDelegate.swift
//  OnlineBankApp
//
//  Created by Dream Store on 28.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         DataManeger.shared.save(array: DataManeger.shared.arrayData)
    }
}

