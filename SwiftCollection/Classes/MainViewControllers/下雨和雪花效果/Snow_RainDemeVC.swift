//
//  Snow&RainVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class Snow_RainDemeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rainView = RainView(frame: CGRect(x: 0, y: 64, width: 100, height: 100))
        rainView.backgroundColor = UIColor.lightGray
        view.addSubview(rainView)
        rainView.show()
    }
}
