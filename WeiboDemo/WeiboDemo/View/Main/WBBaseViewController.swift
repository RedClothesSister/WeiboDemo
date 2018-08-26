//
//  WBBaseViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    // 自定义导航条
    lazy var navigationBar = WBCustomNavigationBar()
    
    // 定义navigationTitle
    lazy var navigationItemTitle = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 重写title的 setter方法
    override var title: String? {
        didSet {
            navigationItemTitle.title = title
        }
    }
}

extension WBBaseViewController {
    
    //设置界面
    @objc func setupUI() {
        view.backgroundColor = UIColor.magenta
        
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将item设置给Bar
        navigationBar.items = [navigationItemTitle]
    }
}
