//
//  AnimateDomeViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/18.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class AnimateDomeViewController: UIViewController {

    @IBOutlet weak var keyframeDemoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonClicked(_ sender: Any) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic, animations: {
            /*
             withRelativeStartTime: 动画开始时间，是一个百分比，相对于总动画时间，这里是 0.5
             relativeDuration: 动画持续时间，是一个百分比，相对于总动画时间
             */
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3.0, animations: {
                self.keyframeDemoButton.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3.0, relativeDuration: 1/3.0, animations: {
                self.keyframeDemoButton.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2/3.0, relativeDuration: 1/3.0, animations: {
                self.keyframeDemoButton.transform = CGAffineTransform.identity
            })
        }, completion: nil)
    }
}
