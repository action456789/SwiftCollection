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

    public var bottomItemHeight: CGFloat {
        if self.navigationController != nil {
            return self.height - self.topItemHeight - 1 - 64
        } else {
            return self.height - self.topItemHeight - 1
        }
    }

    public var delegate: BisetSlideViewControllerDelegate?
    
    fileprivate(set) var currentIndex: Int = 0

    lazy var headerView: BisetSlideHeaderView = {
        return BisetSlideHeaderView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.topItemHeight))
    }()
    
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
        
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.scrollView)
        
        self.scrollView.delegate = self
        
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.topItemHeight)
        }
        
        self.scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
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
            
            self.headerView.slideItems = _slideItems
            
            self.headerView.itemClickEvent = {index in
                self.scrollViewScrollToIndex(index: index)
            }
            
            for (index, item) in _slideItems!.enumerated().reversed() {
                self.scrollView.addSubview(item.viewController!.view)
                
                item.viewController!.view.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.scrollView).offset(CGFloat(index) * self.width)
                    make.top.bottom.equalTo(self.scrollView)
                    make.width.equalTo(self.width)
                    make.height.equalTo(self.bottomItemHeight)
                })
            }
        }
    }
    
    func scrollViewScrollToIndex(index: Int) {
        guard let array = self.slideItems, index < array.count, index >= 0 else {return}
        
        self.delegate?.scrolled?(from: self.currentIndex, to: index)
        self.currentIndex = index
        
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.setContentOffset(CGPoint(x: self.width * CGFloat(index),
                                                     y: 0),
                                             animated: true)
            // autolayout 执行动画
            self.view.layoutIfNeeded()
        })
    }
}

extension BisetSlideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.width
        self.headerView.updateSlide(index: Int(page))
        self.delegate?.scrolled?(from: self.currentIndex, to: Int(page))
        self.currentIndex = Int(page)
    }
}
