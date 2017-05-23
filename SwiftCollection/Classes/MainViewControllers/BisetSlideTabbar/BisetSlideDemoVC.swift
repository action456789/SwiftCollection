//
//  BisetSlideDemoVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class BisetSlideDemoVC: UIViewController {

    lazy var  bisetSlideVC: BisetSlideViewController = {
        let vc = BisetSlideViewController(nibName: nil, bundle: nil)
        vc.delegate = self
        vc.view.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight)
        vc.slider.backgroundColor = UIColor(rgb: 0x13c2c8)
        
        let vc1 = UIViewController(nibName: "BitSlideVC1", bundle: nil)
        vc1.title = "命运石之"
        
        let vc2 = UIViewController(nibName: "BitSlideVC2", bundle: nil)
        vc2.title = "海棠叶"
        
        let vc3 = UIViewController(nibName: "BitSlideVC1", bundle: nil)
        vc3.title = "我是先锋"
        
        vc.setSubViewControllers(subVCs: [vc1, vc2, vc3])
        
        for (index, value) in vc.titleViews.enumerated() {
            if index == 1 {
                value.titleBtn.setImage(UIImage(named: "device"), for: .normal)
                value.titleBtn.setImage(UIImage(named: "device"), for: .highlighted)
            } else if index == 0 {
                value.titleBtn.setImage(UIImage(named: "control"), for: .normal)
                value.titleBtn.setImage(UIImage(named: "control"), for: .highlighted)
            }
        }
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(bisetSlideVC.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bisetSlideVC.view.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
    }
}

extension BisetSlideDemoVC: BisetSlideViewControllerDelegate {
    func scrolled(from: Int, to: Int) {
        print( (from),  (to))
    }
}
