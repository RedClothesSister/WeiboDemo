//
//  WBOAuthViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/31.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = webView
        webView.delegate = self
        
        webView.backgroundColor = UIColor.white
        webView.scrollView.isScrollEnabled = false
        
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
        
        SVProgressHUD.dismiss()
    }
    
    // webView的注入，直接通过js修改 本地浏览器中的缓存页面的内容
    @objc private func autoFill() {
        
        // 准备js
        let js = "document.getElementById('userId').value = '1092592926@qq.com';" + "document.getElementById('passwd').value = 'hjw456831i';"
        
        // 让WebView执行js
        webView.stringByEvaluatingJavaScript(from: js)
    }

}


// MARK: - UIWebViewDelegate Methods

extension WBOAuthViewController: UIWebViewDelegate {
    
    
    // webView将要加载数据
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        // 1.如果请求地址包含 http://baidu.com 不加载页面，否则加载页面
        // 是否包含前缀
        if (request.url?.absoluteString.hasPrefix(WBRedirectURI)) == false {
            return true
        }
        // 2.从http://baidu.com 回调地址中查询 code，如果有，则授权成功，否则授权不成功
        // query 就是 URL中 ？ 后面的所有的东西
        if (request.url?.query?.hasPrefix("code=")) == false {
            
            close()
            return false
        }
        
        let code = request.url?.query?.substring(from: "code=".endIndex)
        print("code--------\(code)")
        
        // 为了登录成功后不出现百度页面
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
