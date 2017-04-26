//
//  RainView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class EmitterView: UIView {

    private lazy var emitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = kCAEmitterLayerLine
        emitterLayer.emitterMode = kCAEmitterLayerSurface
        emitterLayer.emitterSize = CGSize(width: self.frame.width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: CGFloat(self.bounds.size.width / 2.0), y: CGFloat(-20))
        
        return emitterLayer
    }()
    
    private lazy var alphaImageView: UIImageView = {
        let alphaImageView = UIImageView(image: UIImage(named: "alpha"))
        alphaImageView.contentMode = .scaleToFill
        alphaImageView.frame = self.bounds
        return alphaImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.addSublayer(emitterLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    public func rain() {
        let rainflake = CAEmitterCell()
        rainflake.birthRate = 25.0
        rainflake.speed = 10.0
        rainflake.velocity = 10.0
        rainflake.velocityRange = 10.0
        rainflake.yAcceleration = 1000.0
        rainflake.contents = UIImage(named: "rain")?.cgImage
        rainflake.color = UIColor.black.cgColor
        rainflake.lifetime = 10.0
        rainflake.scale = 0.2
        rainflake.scaleRange = 0.0
        // 添加动画
        emitterLayer.emitterCells = [rainflake]
    }
    
    public func snow() {
        let snowflake = CAEmitterCell()
        snowflake.birthRate = 1.0
        snowflake.speed = 10.0
        snowflake.velocity = 2.0
        snowflake.velocityRange = 10.0
        snowflake.yAcceleration = 10.0
        snowflake.emissionRange = 0.5 * .pi
        snowflake.spinRange = 0.25 * .pi
        snowflake.contents = UIImage(named: "snow")?.cgImage
        snowflake.color = UIColor.red.cgColor
        snowflake.lifetime = 200
        snowflake.scale = 0.5
        snowflake.scaleRange = 0.3
        // 添加动画
        emitterLayer.emitterCells = [snowflake]
    }
    
    public func alphaBoundRain() {
        self.mask = alphaImageView
        rain()
    }
    
    public func alphaBoundSnow() {
        self.mask = alphaImageView
        snow()
    }
}


