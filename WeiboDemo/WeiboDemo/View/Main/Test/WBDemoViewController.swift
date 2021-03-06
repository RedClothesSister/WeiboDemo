//
//  WBDemoViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func showNext() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WBDemoViewController {
    @objc override func setupTableView() {
        super.setupTableView()

         navigationItemTitle.rightBarButtonItem = UIBarButtonItem(title: "下一个", textColor: UIColor.themeColor, target: self, action: #selector(showNext))
    }
}
