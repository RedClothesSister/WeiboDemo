//
//  WBProfileViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBProfileViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WBProfileViewController {
    
    override func setupUI() {
        super.setupUI()
        
        navigationItemTitle.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
