//
//  UIBarButtonItem+Extension.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String, textColor: UIColor, target: AnyObject?, action: Selector, isBackButton: Bool = false) {
        
        let baseButton = UIButton()
        baseButton.setTitle(title, for: .normal)
        baseButton.setTitleColor(textColor, for: .normal)
        baseButton.setTitleColor(UIColor.orange, for: .highlighted)
        baseButton.addTarget(target, action: action, for: .touchUpInside)
        
        if isBackButton {
            baseButton.setImage(#imageLiteral(resourceName: "navigationbar_back_withtext"), for: .normal)
            baseButton.setImage(#imageLiteral(resourceName: "navigationbar_back_withtext_highlighted"), for: .highlighted)
            // 重新调整大小
            baseButton.sizeToFit()
        }
        
        self.init(customView: baseButton)
    }
}
