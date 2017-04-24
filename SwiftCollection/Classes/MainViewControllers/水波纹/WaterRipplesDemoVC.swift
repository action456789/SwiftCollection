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

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: ScreenHeight * 0.5))
        
        var y = CGFloat(0)
        for i in stride(from: 0, to: ScreenWidth+1, by: 1) {
            y = 100 * sin(CGFloat.pi * 2 / ScreenWidth * i) + 400
            print(y)
            path.addLine(to: CGPoint(x: i, y: y))
        }
        
        let lay = CAShapeLayer()
        lay.fillColor = UIColor.clear.cgColor
        lay.strokeColor = UIColor.black.cgColor
        lay.path = path
        
        self.view.layer.addSublayer(lay)
    }
}
