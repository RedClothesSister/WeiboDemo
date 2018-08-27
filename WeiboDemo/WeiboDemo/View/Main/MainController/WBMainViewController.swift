//
//  WBMainViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {
    
    private lazy var composeButton = UIButton()
    
    private lazy var orientations = UIInterfaceOrientationMask.portrait

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
        setupComposeButton()
        
    }
    
    // 设置屏幕的方向
    /*
     * portrait -> 竖屏，肖像
     * landscape -> 横屏，风景
     * 使用代码控制设备的方向，好处：可以在需要横屏的时候单独处理。
     * 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
     * 如果需要横屏，可以通过Model展现
    */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return orientations
        }
        set {
            orientations = newValue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func composeButtonClick() {
        
        // 测试旋转方向
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.magenta
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
}

extension WBMainViewController {
    
    // 设置TabBar中间按钮
    private func setupComposeButton() {
        // 设置按钮的图片和背景颜色
        composeButton.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        composeButton.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        
        tabBar.addSubview(composeButton)
        
        // 设置按钮的位置
        // 计算item的个数
        let count = CGFloat(childViewControllers.count)
        // 计算每一个宽度的个数
        let tabBarWidth = tabBar.bounds.width / count - 1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * tabBarWidth, dy: 0)
        
        // 设置按钮监听方法
        composeButton.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
    }
    
    // 设置所有的子控制器
    private func setupChildController() {
        let array = [
            ["clsName": "WBHomeViewController", "title": "首页", "imageName": "home"],
            ["clsName": "WBMessageViewController", "title": "消息", "imageName": "message"],
            ["clsName": "UIViewController"],
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
        
        // 1.取得字典内容
        guard let clsName = dict["clsName"],
              let title = dict["title"],
              let imageName = dict["imageName"],
              let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type else {
                return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        // 3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4.设置tabbar标题字体
        tabBar.tintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}