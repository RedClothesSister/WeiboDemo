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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", textColor: UIColor.themeColor, target: self, action: #selector(autoFill))

        
        // 加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURI)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 监听方法
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // webView的注入，直接通过js修改 本地浏览器中的缓存页面的内容
    @objc private func autoFill() {
        
        // 准备js
        let js = "document.getElementById('userId').value = '1092592926';" + "document.getElementById('passwd').value = 'hjw456831i';"
        
        // 让WebView执行js
        webView.stringByEvaluatingJavaScript(from: js)
    }

}
