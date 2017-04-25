//
//  RadarViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class RadarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let radarView = RadarView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: ScreenWidth))
        view.addSubview(radarView)
        
        radarView.startPulsingAnimate()
        radarView.startStarAnim()
    }

}
