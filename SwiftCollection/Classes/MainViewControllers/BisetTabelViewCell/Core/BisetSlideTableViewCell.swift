//
//  BisetSlideTableViewCell.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/29.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

@objc protocol BisetSlideTableViewCellDelegate {
    @objc optional func scrolled(from: Int, to: Int)
}

class BisetSlideTableViewCell: UITableViewCell {

    public var width = UIScreen.main.bounds.width
    
    public var delegate: BisetSlideTableViewCellDelegate?
    
    fileprivate(set) var currentIndex: Int = 0
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
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
                self.scrollView.addSubview(item.viewController!.view)
                
                item.viewController!.view.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.scrollView).offset(CGFloat(index) * self.width)
                    make.top.bottom.equalTo(self.scrollView)
                    make.width.equalTo(self.width)
                    make.height.equalTo(self)
                })
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.scrollView.contentSize = CGSize(width: self.width * CGFloat(self.slideItems!.count), height: 0)
            }
        }
    }

    func scrollToIndex(index: Int) {
        guard let array = self.slideItems, index < array.count, index >= 0 else {return}
        
        self.delegate?.scrolled?(from: self.currentIndex, to: index)
        self.currentIndex = index
        
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.setContentOffset(CGPoint(x: self.width * CGFloat(index),
                                                     y: 0),
                                             animated: true)
            // autolayout 执行动画
            self.layoutIfNeeded()
        })
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension BisetSlideTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.width
        self.delegate?.scrolled?(from: self.currentIndex, to: Int(page))
        self.currentIndex = Int(page)
    }
}

