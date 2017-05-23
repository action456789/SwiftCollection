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

    public private(set) var titleViews = [BisetSlideItemView]()
    
    let sliderTopPading = 5
    
    var delegate: BisetSlideViewControllerDelegate?
    
    fileprivate(set) var currentIndex: Int = 0
    
    private var subVCs = [UIViewController]()
    
    fileprivate var bottomViewWidth: CGFloat {
        return topContainerView.frame.width
    }
    
    fileprivate lazy var topItemWidth: Int = {
        return Int(self.view.frame.width / CGFloat(self.subVCs.count))
    }()
    
    @IBOutlet weak var topContainerView: UIView!
    
    @IBOutlet public weak var slider: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var slideWidthCons: NSLayoutConstraint!
    @IBOutlet weak var slideLeadingCons: NSLayoutConstraint!
    
    public func setSubViewControllers(subVCs: [UIViewController]) {
        
        self.subVCs = subVCs
        
        slideWidthCons.constant = CGFloat(topItemWidth - sliderTopPading * 2)
        
        for (index, subVC) in subVCs.enumerated().reversed() {
            
            // setup title
            
            let title = subVC.title
            
            let titleView = Bundle.main.loadNibNamed("BisetSlideItemView", owner: nil, options: nil)?.last as! BisetSlideItemView
            topContainerView.addSubview(titleView)
            
            titleView.titleBtn.setTitle(title, for: .normal)
            titleView.titleBtn.setTitle(title, for: .highlighted)
            
            titleView.seperaterLine.isHidden = index == subVCs.count - 1
            
            titleView.frame = CGRect(x: index * topItemWidth,
                                     y: 0,
                                     width: topItemWidth,
                                     height: Int(topContainerView.frame.height))
            
            titleView.titleBtn.tag = index
            
            titleViews.append(titleView)
            
            // 按钮点击事件
            titleView.buttonEvent = {sender in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.slideLeadingCons.constant = CGFloat(self.topItemWidth * index + self.sliderTopPading)
                    self.scrollView.setContentOffset(CGPoint(x: self.bottomViewWidth * CGFloat(index),
                                                             y: 0),
                                                     animated: true)
                    // autolayout 执行动画
                    self.view.layoutIfNeeded()
                })
                
                // 执行代理事件
                self.delegate?.scrolled?(from: self.currentIndex, to: sender.tag)
                self.currentIndex = sender.tag
            }
            
            // setup bottom ViewController
            let width = self.view.frame.width
            
            scrollView.contentSize = CGSize(width: width * CGFloat(subVCs.count),
                                            height: CGFloat(0))
            scrollView.addSubview(subVC.view)
            subVC.view.frame = CGRect(x: CGFloat(index) * width,
                                      y: 0,
                                      width: width,
                                      height: scrollView.frame.height)
        }
        
    }
}

extension BisetSlideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / bottomViewWidth)
        
        UIView.animate(withDuration: 0.3) { 
            self.slideLeadingCons.constant = CGFloat(self.topItemWidth * page + self.sliderTopPading)
            self.view.layoutIfNeeded()
        }
        
        self.delegate?.scrolled?(from: self.currentIndex, to: page)
        self.currentIndex = page
    }
}
