//
//  VidioMedioViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/29.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class VidioMedioViewController: UIViewController {

    let tool = MedioTool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tool.startTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
