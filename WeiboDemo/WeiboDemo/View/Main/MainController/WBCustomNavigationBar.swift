//
//  WBCustomNavigationBar.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBCustomNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subView in subviews {
            let stringFromClass = NSStringFromClass(subView.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subView.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subView.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 44)
            }
        }
    }

}
