//
//  M34DemoViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/10/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//  http://www.cocoachina.com/swift/20170518/19305.html?utm_source=tuicool&utm_medium=referral

import UIKit

class M34DemoViewController: UIViewController {

    @IBOutlet weak var animateView: UIView!
    
    var angle = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View 需要用手势移动当作依据，所以不直接对这个 View 做旋转，而是旋转 View 里面的 sublayer，layer 里面的有个方法可以实作这个功能 sublayerTransform ，并把内容以 subView 的方式加入，然后把 blueView 的 backgroundColor 拿掉，这样就能很正常的转动了。
        let subView = UIView.init(frame: animateView.bounds)
        subView.backgroundColor = UIColor.blue
        animateView.addSubview(subView)
        animateView.backgroundColor = UIColor.clear
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
        animateView.addGestureRecognizer(panGesture)
    }
    
    @objc func viewTransform(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: animateView)
        let angleX = self.angle.x + (point.x/30)
        let angleY = self.angle.y - (point.y/30)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        animateView.layer.sublayerTransform = transform
        
        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
    }
}
