//
//  GraduallyTransparentVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import SnapKit

// 参考：http://www.cocoachina.com/ios/20160606/16608.html

class GraduallyTransparentVC: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var navbarImage: UIView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        mainScrollView.bounces = true
        mainScrollView.delegate = self
        mainScrollView.contentSize = CGSize(width: ScreenWidth, height: ScreenHeight * 2)
        
        // 获取导航栏图片 View
        navbarImage = navigationController?.navigationBar.subviews.first!
        
        createSubviews()
    }
    
    private func createSubviews() {
        
        // 向 UIScrollView中增加子View，子View的宽高一定要知道，最好用代码布局
        let imageView = UIImageView(image: UIImage(named: "h7"))
        mainScrollView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(mainScrollView)
            make.top.equalTo(mainScrollView).offset(-60)
            make.height.equalTo(220)
            make.width.equalTo(ScreenWidth)
        }
    }
}

extension GraduallyTransparentVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let minAlphaOffset: CGFloat = -64
        let maxAlphaOffset: CGFloat = 200
        let offset: CGFloat = scrollView.contentOffset.y
        let alpha: CGFloat = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset)
        
        if let image = navbarImage {
            image.alpha = alpha
        }
    }
}
