//
//  AppDelegate.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ListVC())
        window?.makeKeyAndVisible()

        return true
    }
}
