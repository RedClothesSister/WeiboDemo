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
    lazy var registerButton = UIButton()
    
    // 登录按钮
    lazy var loginButton = UIButton()
    
    // 访客视图的信息字典
    var visitorInfo: [String: String]? {
        didSet {
            // 1.取字典信息
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            
            // 2.设置消息
            tipLabel.text = message
            
            // 3.设置图像，首页不需要设置
            if imageName == "" {
                rotationAnimate()
                return
            }
            iconView.image = UIImage(named: imageName)
            
            // 其他控制器的视图显示图像
            houseIconView.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 旋转动画
    func rotationAnimate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotation.toValue = 2 * Double.pi
        rotation.duration = 30
        rotation.repeatCount = MAXFLOAT
        
        // 动画完成之后不删除
        rotation.isRemovedOnCompletion = false
        
        iconView.layer.add(rotation, forKey: "rotation")
    }
}

extension WBVisitorView {
    
    func setupUI() {
        backgroundColor = UIColor.VisitorBackgroundColor
        
        iconView.alpha = 0.7
        houseIconView.alpha = 0.7
        
        tipLabel.text = "关注一下，回这里看看有什么惊喜"
        tipLabel.textColor = UIColor.themeColor
        tipLabel.font = UIFont.boldSystemFont(ofSize: 15)
        tipLabel.numberOfLines = 0
        tipLabel.textAlignment = .center
        
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
        
        tipLabel.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        tipLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20).isActive = true
        tipLabel.widthAnchor.constraint(equalToConstant: 236).isActive = true
        
        registerButton.leftAnchor.constraint(equalTo: tipLabel.leftAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: tipLabel.topAnchor, constant: 50).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        loginButton.rightAnchor.constraint(equalTo: tipLabel.rightAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: tipLabel.topAnchor, constant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
