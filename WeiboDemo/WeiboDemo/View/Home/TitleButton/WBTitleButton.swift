//
//  WBTitleButton.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/9/3.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    // 如果title是nil 则显示 微博
    // 如果不为nil，显示title和图像
    init(title: String?) {
        super.init(frame: CGRect())
        
        // 先判断title是否为nil
        if title == nil {
            setTitle("微博", for: .normal)
        } else {
            setTitle(title! + " ", for: .normal)
            
            // 设置显示的图像
            setImage(#imageLiteral(resourceName: "navigationbar_arrow_down"), for: .normal)
            setImage(#imageLiteral(resourceName: "navigationbar_arrow_up"), for: .selected)
        }
        
        // 设置字体和字体颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        
        // 设置图像大小
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()

        guard let titleLabel = titleLabel, let imageView = imageView else {
            return
        }
        
        // 调整Label和imageView的位置
        let titleSize = titleLabel.bounds.size
        let imageSize = imageView.bounds.size
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: 0, right: imageSize.width)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width, bottom: 0, right: -titleSize.width)
        
    }
}
