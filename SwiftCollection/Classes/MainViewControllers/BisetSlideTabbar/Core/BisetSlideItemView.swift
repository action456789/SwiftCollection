//
//  BisetSlideItemView.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import SnapKit

class BisetSlideItemView: UIView {
    
    lazy var titleBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor(rgb: 0x333333), for: .normal)
        btn.setTitleColor(UIColor(rgb: 0x666666), for: .highlighted)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        btn.addTarget(self, action: #selector(self.buttonEvent(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var seperaterLine = UIView()
    
    public var topItemHeight = CGFloat(45)
    
    var buttonEvent: ((_ sender: UIButton) -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.seperaterLine.backgroundColor = UIColor.groupTableViewBackground
        
        self.addSubview(self.titleBtn)
        self.addSubview(self.seperaterLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        get {
            return true
        }
    }
    
    override func updateConstraints() {
        self.titleBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.right.equalTo(self).offset(1)
        }
        
        self.seperaterLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.size.equalTo(CGSize(width: 1,
                                     height: topItemHeight * 0.4))
        }
        
        super.updateConstraints()
    }
    
    @objc func buttonEvent(_ sender: UIButton) {
        buttonEvent?(sender)
    }
}

