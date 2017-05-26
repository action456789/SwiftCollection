//
//  BisetSlideItem.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/25.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class BisetSlideItem: NSObject {
    var title: String?
    var norImage: String?
    var highlightImage: String?
    var viewController: UIViewController?
    
    init(title: String? = nil, image: String? = nil, highLightImage: String? = nil, viewController: UIViewController) {
        super.init()
        
        self.title = title
        self.norImage = image
        self.highlightImage = highLightImage
        self.viewController = viewController
    }
}
