//
//  BaseNavigationController.swift
//  SKS_CollectionSwift
//
//  Created by KeSen on 7/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
        delegate = self
    }
}
