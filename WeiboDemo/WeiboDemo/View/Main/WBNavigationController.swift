//
//  WBNavigationController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏默认的NavigationBar
        navigationBar.isHidden = true
    }
    
    //重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            //隐藏底部的Tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
    }
}
