//
//  WBMessageViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBMessageViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func test() {
        
    }

}

extension WBMessageViewController {
    
    override  func setupTableView() {
        super.setupTableView()
        navigationItemTitle.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
