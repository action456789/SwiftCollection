//
//  RainView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class RainView: UIView {

    lazy var emitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.masksToBounds = true
        emitterLayer.emitterShape = kCAEmitterLayerLine
        emitterLayer.emitterMode = kCAEmitterLayerSurface
        emitterLayer.emitterSize = self.frame.size
        emitterLayer.emitterPosition = CGPoint(x: CGFloat(self.bounds.size.width / 2.0), y: CGFloat(-20))
        
        return emitterLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(emitterLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    public func show() {
        let rainflake = CAEmitterCell()
        rainflake.birthRate = 25.0
        rainflake.speed = 10.0
        rainflake.velocity = 10.0
        rainflake.velocityRange = 10.0
        rainflake.yAcceleration = 1000.0
        rainflake.contents = UIImage(named: "rain")?.cgImage
        rainflake.color = UIColor.black.cgColor
        rainflake.lifetime = 7.0
        rainflake.scale = 0.2
        rainflake.scaleRange = 0.0
        // 添加动画
        emitterLayer.emitterCells = [rainflake]
    }
}


