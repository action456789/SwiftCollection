//
//  WaterRipplesDemoVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class WaterRipplesDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let waterView = WaterRipplesView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 100))
        view.addSubview(waterView)
    }
}
