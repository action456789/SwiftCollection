//
//  BisetSlideItemView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class BisetSlideItemView: UIView {

    typealias btnEventBlock = (_ sender: UIButton) -> Void
    
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var seperaterLine: UIView!
    
    var buttonEvent: btnEventBlock? = nil
    
    @IBAction func buttonEvent(_ sender: UIButton) {
        buttonEvent?(sender)
    }
}
