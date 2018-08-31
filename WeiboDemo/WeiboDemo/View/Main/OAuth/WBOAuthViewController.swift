//
//  WBOAuthViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/31.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = webView
        
        webView.backgroundColor = UIColor.white
        
        // 设置导航栏
        title = "登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", textColor: UIColor.themeColor, target: self, action: #selector(close), isBackButton: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 监听方法
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    

}
