//
//  WBMainViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WBMainViewController {
    
    //设置所有的子控制器
    private func setupChildController() {
        let array = [
            ["clsName": "WBHomeViewController", "title": "首页", "imageName": "home"],
            ["clsName": "WBMessageViewController", "title": "消息", "imageName": "message"],
            ["clsName": "WBDiscoverViewController", "title": "发现", "imageName": "discover"],
            ["clsName": "WBProfileViewController", "title": "我的", "imageName": "profile"]
        ]
        
        var arrayModel = [UIViewController]()
        for dict in array {
            arrayModel.append(controller(dict: dict))
        }
        
        viewControllers = arrayModel
    }
    
    private func controller(dict: [String: String]) -> UIViewController {
        
        //1.取得字典内容
        guard let clsName = dict["clsName"],
              let title = dict["title"],
              let imageName = dict["imageName"],
              let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type else {
                return UIViewController()
        }
        
        //2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        //3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}
