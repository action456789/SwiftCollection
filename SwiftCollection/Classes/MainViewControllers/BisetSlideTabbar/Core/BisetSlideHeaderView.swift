//
//  BisetSlideHeaderView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/29.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import SnapKit

class BisetSlideHeaderView: UIView {
    public var sliderTopPading = CGFloat(5)
    public var sliderHeight = CGFloat(2)
    public var slideBackgroundColor = UIColor(rgb: 0x13c2c8)
    
    var itemClickEvent: ((_ index: Int) -> Void)? = nil
    
    lazy var slider: UIView = {
        let view = UIView()
        view.backgroundColor = self.slideBackgroundColor
        return view
    }()
    
    var itemWidth: CGFloat {
        return self.bounds.size.width / CGFloat(_slideItems!.count)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSlide(index: Int) {
        guard let array = self.slideItems, index < array.count, index >= 0 else {
            return
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.slider.snp.updateConstraints({ (make) in
                make.left.equalTo(self).offset(self.itemWidth * CGFloat(index) + self.sliderTopPading)
            })
            self.layoutIfNeeded()
        })
    }
    
    private var _slideItems: [BisetSlideItem]?
    var slideItems: [BisetSlideItem]? {
        get {
            return _slideItems
        }
        set {
            _slideItems = newValue
            
            guard _slideItems != nil else {
                return
            }
            
            for (index, item) in _slideItems!.enumerated().reversed() {
                // top
                let itemView = BisetSlideItemView(frame: .zero)
                self.addSubview(itemView)
                
                if let title = item.title {
                    itemView.titleBtn.setTitle(title, for: .normal)
                    itemView.titleBtn.setTitle(title, for: .highlighted)
                }
                
                if let image = item.norImage {
                    itemView.titleBtn.setImage(UIImage.init(named: image), for: .normal)
                }
                
                if let highlightImage = item.highlightImage {
                    itemView.titleBtn.setImage(UIImage.init(named: highlightImage), for: .highlighted)
                }
                
                itemView.seperaterLine.isHidden = index == _slideItems!.count - 1
                itemView.titleBtn.tag = index
                
                // 按钮点击事件
                itemView.buttonEvent = { sender in
                    
                    self.itemClickEvent?(index)
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        self.slider.snp.updateConstraints({ (make) in
                            make.left.equalTo(self).offset(self.itemWidth * CGFloat(index) + self.sliderTopPading)
                        })
                        
                        // autolayout 执行动画
                        self.layoutIfNeeded()
                    })
                }
                
                itemView.snp.makeConstraints({ (make) in
                    make.left.equalTo(self).offset(CGFloat(index) * itemWidth)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self).offset(self.sliderHeight)
                    make.width.equalTo(itemWidth)
                })
            }
        
            self.slider.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(sliderTopPading)
                make.bottom.equalTo(self)
                make.height.equalTo(self.sliderHeight)
                make.width.equalTo(itemWidth - 2 * self.sliderTopPading)
            }
        }
    }
}
