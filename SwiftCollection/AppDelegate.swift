//
//  AppDelegate.swift
//  SwiftCollection
//
//  Created by KeSen on 7/29/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds);
        let rootVc = RootViewController()
        let nav = BaseNavigationController(rootViewController: rootVc)
        
        window?.rootViewController = nav;
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        // Alamofire
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
        manager?.startListening()
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        return true
    }
}

