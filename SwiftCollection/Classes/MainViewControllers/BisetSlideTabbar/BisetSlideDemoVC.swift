//
//  BisetSlideDemoVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class BisetSlideDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = BisetSlideViewController.init(nibName: nil, bundle: nil)
        vc.delegate = self
        vc.view.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
        self.view.addSubview(vc.view)
        
        let vc1 = UIViewController(nibName: "BitSlideVC1", bundle: nil)
        vc1.title = "命运石之"
        
        let vc2 = UIViewController(nibName: "BitSlideVC2", bundle: nil)
        vc2.title = "海棠叶"
        
        let vc3 = UIViewController(nibName: "BitSlideVC1", bundle: nil)
        vc3.title = "我是先锋"
        
        vc.setup(subVCs: [vc1, vc2, vc3])
    }
}

extension BisetSlideDemoVC: BisetSlideViewControllerDelegate {
    func scrolled(from: Int, to: Int) {
        print( (from),  (to))
    }
}
