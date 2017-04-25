//
//  RadarView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

// 参考：http://blog.csdn.net/zhangao0086/article/details/38170359

import UIKit

class RadarView: UIView {
    
    let pulsingCount = 6
    let animationDuration: Double = 6
    var animateLayers = [CAShapeLayer]()
    
    private var isPulsingAnimating = false
    private var isStarAnimating = false
    
    let itemSize = CGSize(width: 44, height: 44)
    var items = [StartButton]()
    var timer: Timer?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.resume),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.resign),
                                               name: NSNotification.Name.UIApplicationWillResignActive,
                                               object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cleanTimer()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // 优化：在动画播放的时候你按下 Home 键时，所有的动画被移除了，每个 Layer 都调用了 removeAllAnimations 方法
    @objc private func resume() {
        if isPulsingAnimating {
            startPulsingAnimate()
        }
        
        if isStarAnimating {
            startStarAnim()
        }
    }
    
    @objc private func resign() {
        _ = animateLayers.map({$0.removeFromSuperlayer()})
        animateLayers.removeAll()
        
        _ = items.map({$0.removeFromSuperview()})
        items.removeAll()
        
        cleanTimer()
    }

    func cleanTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: - 雷达动画
    
    public func startPulsingAnimate() {
        isPulsingAnimating = true
        
        for i in stride(from: 0, to: pulsingCount, by: 1) {
            let layer = createLayer()
            animateLayers.append(layer)
            self.layer.addSublayer(layer)
            
            // 产生圆圈的时间间隔 
            let delay = Double(i) * animationDuration / Double(pulsingCount)
            startPulsingAnimat(layer: layer, delay: delay)
        }
    }
    
    private func createLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.frame.size = self.frame.size
        layer.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        
        let ovalPath = UIBezierPath(ovalIn: self.bounds)
        layer.path = ovalPath.cgPath
    
        return layer
    }
    
    private func startPulsingAnimat(layer: CAShapeLayer, delay: Double) {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.autoreverses = false
        scaleAnim.fromValue = Double(0)
        scaleAnim.toValue = Double(1.3)
        
        let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnim.values = [Double(1), Double(0.7), Double(0)]
        opacityAnim.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.5), NSNumber(value: 1)]
        
        let animGroup = CAAnimationGroup()
        animGroup.fillMode = kCAFillModeBackwards
        animGroup.beginTime = CACurrentMediaTime() + delay
        animGroup.duration = animationDuration
        animGroup.repeatCount = HUGE
        animGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        animGroup.animations = [scaleAnim, opacityAnim]
        
        layer.add(animGroup, forKey: "pulsing")
    }
    
    //MARK: - 在圆形范围内随机生成 button
    
    // 在圆形范围内随机生成坐标点
    private func generateCenterPointInRadar() -> CGPoint {
        let angle = Double(arc4random()).truncatingRemainder(dividingBy: 360)// 取余，truncatingRemainder 即 OC 中的 %
        let radius = Double(arc4random()).truncatingRemainder(dividingBy: (Double)((self.bounds.size.width - itemSize.width)/2))
        
        // 圆的参数方程：以点O（a，b）为圆心，以r为半径的圆的参数方程是 x=a+r*cosθ, y=b+r*sinθ
        let x = cos(angle) * radius
        let y = sin(angle) * radius
        
        return CGPoint(x: CGFloat(x) + self.bounds.size.width / 2, y: CGFloat(y) + self.bounds.size.height / 2)
    }
    
    @objc private func addOrReplaceItem() {
        let maxCount = 10
        
        let radarButton = StartButton(frame: CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
        radarButton.setImage(UIImage(named: "star"), for: .normal)
        
        let center = generateCenterPointInRadar()
        radarButton.center = CGPoint(x: center.x, y: center.y)
        
        // 去重
        if itemFrameIntersectsInOtherItem(frame: radarButton.frame) {
            return
        }
        
        self.addSubview(radarButton)
        items.append(radarButton)
        
        if items.count > maxCount {
            items[0].removeFromSuperview()
            items.remove(at: 0)
        }
    }
    
    // 优化：去掉位置重叠的✨
    private func itemFrameIntersectsInOtherItem (frame: CGRect) -> Bool {
        for item in items {
            if item.frame.intersects(frame) {
                return true
            }
        }
        return false
    }
    
    public func startStarAnim() {
        isStarAnimating = true
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.addOrReplaceItem), userInfo: nil, repeats: true)
    }
}
