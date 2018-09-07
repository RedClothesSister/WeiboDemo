//
//  WBNewFeatureView.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/9/4.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var pageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WBNewFeatureView {
    
    // 设置界面
    private func setupUI() {
        let count = 3
        let rect = UIScreen.main.bounds
        scrollView.frame = rect
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        addSubview(scrollView)
        
        for i in 0 ..< count {
            let imageName = "Welcome\(i + 1)"
            let welcomeImage = UIImageView(image: UIImage(named: imageName))
            
            // 设置大小
            welcomeImage.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(welcomeImage)
            addSubview(pageControl)
        }
        
        pageControl.alpha = 0.5
        pageControl.center = CGPoint(x: 0, y: rect.height - 60)
        
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.white
        
        pageControl.numberOfPages = 3
        pageControl.addTarget(self, action: #selector(scrollViewDidEndDecelerating), for: .valueChanged)
    }
}


// MARK: - UIScrollViewDelegate Methods

extension WBNewFeatureView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 滚动到最后一页，让视图删除
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        if index == scrollView.subviews.count {
            removeFromSuperview()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        pageControl.currentPage = page
        
        // 分页控件的隐藏
        if page == scrollView.subviews.count {
            pageControl.isHidden = true
        } else {
            pageControl.isHidden = false
        }
        
        
    }
}
