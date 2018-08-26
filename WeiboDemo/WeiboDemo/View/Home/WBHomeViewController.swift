//
//  WBHomeViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func showFriends() {
        
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WBHomeViewController {
    
    // 重写父类的方法
    override func setupUI() {
        super.setupUI()

        navigationItemTitle.leftBarButtonItem = UIBarButtonItem(title: "好友", textColor: UIColor.themeColor, target: self, action: #selector(showFriends))
        
    }
}
