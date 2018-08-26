//
//  UIBarButtonItem+Extension.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String, textColor: UIColor, target: AnyObject?, action: Selector) {
        
        let baseButton = UIButton()
        baseButton.setTitle(title, for: .normal)
        baseButton.setTitleColor(textColor, for: .normal)
        baseButton.setTitleColor(UIColor.orange, for: .highlighted)
        baseButton.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: baseButton)
    }
}
