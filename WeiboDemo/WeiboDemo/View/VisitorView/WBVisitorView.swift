//
//  WBVisitorView.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/27.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {
    
    // 图像视图
   private lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))

    // 小房子视图
    private lazy var houseIconView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
    // 提示标签
    private lazy var tipLabel = UILabel()
    
    // 注册按钮
    private lazy var registerButton = UIButton()
    
    // 登录按钮
    private lazy var loginButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WBVisitorView {
    
    func setupUI() {
        backgroundColor = UIColor.white
        
        tipLabel.text = "关注一下，回这里看看有什么惊喜"
        tipLabel.textColor = UIColor.themeColor
        tipLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(UIColor.orange, for: .normal)
        registerButton.setTitleColor(UIColor.themeColor, for: .highlighted)
        registerButton.setBackgroundImage(#imageLiteral(resourceName: "common_button_white_disable"), for: .normal)
        
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.themeColor, for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .highlighted)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "common_button_white_disable"), for: .normal)
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 2.取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
       
        // 3.自动布局
        iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60).isActive = true
        
        houseIconView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        houseIconView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor, constant: -6).isActive = true
        
        
    }
}
