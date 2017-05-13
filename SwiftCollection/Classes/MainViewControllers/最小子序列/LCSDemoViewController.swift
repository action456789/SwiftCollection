//
//  LCSDemoViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/28.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import SwiftLCS

class LCSDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        string()
        array()
        indexes()
    }
    
    func string() {
        let x = "abracadabra"
        let y = "yabbadabbadoo"
        
        let z = x.longestCommonSubsequence(y) // abadaba
        print(z)
    }
    
    func array() {
        let x = [1, 2, 3, 4, 5, 6, 7]
        let y = [8, 9, 2, 10, 4, 11, 6, 12]
        
        let z = x.longestCommonSubsequence(y) // [2, 4, 6]
        print(z)
    }
    
    func indexes() {
        let x = [1, 2, 3, 4, 5, 6, 7]
        let y = [8, 9, 2, 10, 4, 11, 6, 12]
        
        let diff = x.diff(y)
        print(diff.commonIndexes) // 公共部分的下标为：[1, 3, 5] 即 [2, 4, 6]
        print(diff.addedIndexes) // 增加的部分下标为：[0, 1, 3, 5, 7]
        print(diff.removedIndexes) // 移除的部分下标：[0, 2, 4, 6]
    }
}
