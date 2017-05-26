//
//  BisetSlideViewController.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol BisetSlideViewControllerDelegate {
    @objc optional func scrolled(from: Int, to: Int)
}

class BisetSlideViewController: UIViewController {

    public var width = UIScreen.main.bounds.width
    public var height = UIScreen.main.bounds.height
    public var topItemHeight = CGFloat(45)
    public var sliderTopPading = CGFloat(5)
    public var sliderHeight = CGFloat(2)
    public var slideBackgroundColor = UIColor(rgb: 0x13c2c8)
    
    public var bottomItemHeight: CGFloat {
        if self.navigationController != nil {
            return self.height - self.topItemHeight - 1 - 64
        } else {
            return self.height - self.topItemHeight - 1
        }
    }

    lazy var slider: UIView = {
        let view = UIView()
        view.backgroundColor = self.slideBackgroundColor
        return view
    }()
    
    public var delegate: BisetSlideViewControllerDelegate?
    
    fileprivate(set) var currentIndex: Int = 0

    private var topContainerView: UIView = UIView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.topContainerView)
        self.view.addSubview(self.slider)
        self.view.addSubview(self.scrollView)
        
        self.scrollView.delegate = self
        
        self.topContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.topItemHeight)
        }
        
        self.scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.slider.snp.bottom)
            make.size.equalTo(CGSize(width: self.view.frame.width,
                                     height: self.bottomItemHeight))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { 
            self.scrollView.contentSize = CGSize(width: self.width * CGFloat(self.slideItems!.count), height: 0)
        }
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
            
            let itemWidth = self.width / CGFloat(_slideItems!.count)
            
            for (index, item) in _slideItems!.enumerated().reversed() {
                // top
                let topItemView = BisetSlideItemView(frame: .zero)
                self.topContainerView.addSubview(topItemView)
                
                if let title = item.title {
                    topItemView.titleBtn.setTitle(title, for: .normal)
                    topItemView.titleBtn.setTitle(title, for: .highlighted)
                }
                
                if let image = item.norImage {
                    topItemView.titleBtn.setImage(UIImage.init(named: image), for: .normal)
                }
                
                if let highlightImage = item.highlightImage {
                    topItemView.titleBtn.setImage(UIImage.init(named: highlightImage), for: .highlighted)
                }
                
                topItemView.seperaterLine.isHidden = index == _slideItems!.count - 1
                topItemView.titleBtn.tag = index
                
                // 按钮点击事件
                topItemView.buttonEvent = {sender in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.slider.snp.updateConstraints({ (make) in
                            make.left.equalTo(self.view).offset(itemWidth * CGFloat(index) + self.sliderTopPading)
                        })
                        
                        self.scrollView.setContentOffset(CGPoint(x: self.width * CGFloat(index),
                                                                 y: 0),
                                                         animated: true)
                        // autolayout 执行动画
                        self.view.layoutIfNeeded()
                    })
                    
                    // 执行代理事件
                    self.delegate?.scrolled?(from: self.currentIndex, to: sender.tag)
                    self.currentIndex = sender.tag
                }
                
                // bottom
                self.scrollView.addSubview(item.viewController!.view)
                
                // make constraint
                
                topItemView.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.topContainerView).offset(CGFloat(index) * itemWidth)
                    make.top.bottom.equalTo(self.topContainerView)
                    make.width.equalTo(itemWidth)
                })
                
                item.viewController!.view.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.scrollView).offset(CGFloat(index) * self.width)
                    make.top.bottom.equalTo(self.scrollView)
                    make.width.equalTo(self.width)
                    make.height.equalTo(self.bottomItemHeight)
                })
            }
            
            self.slider.snp.makeConstraints { (make) in
                make.left.equalTo(self.view).offset(sliderTopPading)
                make.top.equalTo(self.topContainerView.snp.bottom)
                make.height.equalTo(self.sliderHeight)
                make.width.equalTo(itemWidth - 2 * self.sliderTopPading)
            }

        }
    }
}

extension BisetSlideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.width
        let itemWidth = self.width / CGFloat(self.slideItems!.count)
        
        UIView.animate(withDuration: 0.3) {
            self.slider.snp.updateConstraints({ (make) in
                make.left.equalTo(self.view).offset(itemWidth * page + self.sliderTopPading)
            })
            self.view.layoutIfNeeded()
        }
        
        self.delegate?.scrolled?(from: self.currentIndex, to: Int(page))
        self.currentIndex = Int(page)
    }
}
