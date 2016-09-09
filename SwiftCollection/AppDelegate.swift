//
//  AppDelegate.swift
//  SwiftCollection
//
//  Created by KeSen on 7/29/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.mainScreen().bounds);
        let rootVc = RootViewController()
        let nav = BaseNavigationController(rootViewController: rootVc)
        
        window?.rootViewController = nav;
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        return true
    }
}

