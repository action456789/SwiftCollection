//
//  StartButton.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class StartButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if (self.window != nil) {
            UIView.animate(withDuration: 1, animations: {
                self.alpha = 1
            })
        }
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: 1, animations: { 
            self.alpha = 0
        }) {_ in
            super.removeFromSuperview()
        }
    }
}
