//
//  SpringDemoViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/10/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import Spring

class SpringDemoViewController: UIViewController {

    @IBOutlet weak var springDemoView: SpringView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        springDemoView.animation = Spring.AnimationPreset.FlipY.rawValue
        springDemoView.animate()
    }
    
}
