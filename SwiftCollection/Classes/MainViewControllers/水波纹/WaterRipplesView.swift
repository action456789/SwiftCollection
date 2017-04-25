//
//  WaterRipplesView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class WaterRipplesView: UIView {
    
    lazy var fast: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor(rgb: 0x1565c0).withAlphaComponent(0.6).cgColor
        layer.fillColor = UIColor(rgb: 0x1565c0).withAlphaComponent(0.6).cgColor
        
        return layer
    }()
    
    lazy var slow: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor(rgb: 0x1565c0).withAlphaComponent(0.4).cgColor
        layer.fillColor = UIColor(rgb: 0x1565c0).withAlphaComponent(0.4).cgColor
        
        return layer
    }()
    
    lazy var timer: CADisplayLink = CADisplayLink(target: self, selector: #selector(self.timerEvent))
    
    let speed = CGFloat(2)
    
    // y=Asin（ωx+φ）+ h
    lazy var A: CGFloat = 20 // 振幅，决定最大 y 的值
    lazy var ω: CGFloat = CGFloat.pi / self.frame.width // 最小正周期 = 2π/ω，决定一个周期的x轴跨度，此处为一个周期跨两个view的宽度
    lazy var φ: CGFloat = CGFloat(0)  // 决定在 x 轴上的偏移
    lazy var h: CGFloat = self.frame.height * 0.5  // 波形在 y 轴上的决定偏移
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(fast)
        layer.addSublayer(slow)
        timer.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createWave(layer: CAShapeLayer, A: CGFloat, ω: CGFloat, φ: CGFloat, h: CGFloat) {
        let path: CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(0), y: CGFloat(frame.height / 2)))
        var y: CGFloat = 0.0
        
        for x in stride(from: 0, to: frame.width + 1, by: 1) {
            y = A * sin(ω * x + φ) + h
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
        }
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: CGFloat(0), y: frame.height))
        path.closeSubpath()

        layer.path = path
    }
    
    @objc private func timerEvent() {
        // 波纹移动速度
        φ -= self.frame.width / 60 / 60 / 2
        
        createWave(layer: fast, A: self.A, ω: self.ω, φ: self.φ, h: self.h)
        createWave(layer: slow, A: self.A * 0.5, ω: self.ω * 1.1, φ: self.φ * 0.7 + 100, h: self.h)
    }
}
