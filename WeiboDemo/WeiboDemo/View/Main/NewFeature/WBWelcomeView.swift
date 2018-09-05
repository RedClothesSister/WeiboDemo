//
//  WBWelcomeView.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/9/4.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomeView: UIView {
    
    private lazy var backgroundImage = UIImageView()
    
    private lazy var iconImage = UIImageView()
    
    private lazy var tipLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        // 设置控件的布局
        setupLayout()
        // 设置空间的动画
        setupAnimate()
        
        // 设置用户头像
        setupUserAvata()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension WBWelcomeView {
    private func setupUI() {
        
        //  设置背景图片
        backgroundImage.image = UIImage(named: "ad_background")
        addSubview(backgroundImage)
        
        // 设置人物头像
        iconImage.image = UIImage(named: "avatar_default_big")
        iconImage.layer.cornerRadius = 42.5
        iconImage.clipsToBounds = true
        insertSubview(iconImage, aboveSubview: backgroundImage)
        
        // 设置提示标题
        tipLabel.text = "欢迎回来"
        tipLabel.alpha = 0
        tipLabel.font = UIFont.boldSystemFont(ofSize: 17)
        insertSubview(tipLabel, aboveSubview: backgroundImage)
    }
    
    private func setupLayout() {
        backgroundImage.frame = UIScreen.main.bounds
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 85).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tipLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 15).isActive = true
    }
    
    private func setupAnimate() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.iconImage.transform = CGAffineTransform(translationX: 0, y: -(UIScreen.main.bounds.height - 360))
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.tipLabel.transform = CGAffineTransform(translationX: 0, y: -(UIScreen.main.bounds.height - 355))
            self.tipLabel.alpha = 1
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func setupUserAvata() {
        guard let urlString = WBNetworkManager.shared.userAccount.avatar_large,
              let url = URL(string: urlString) else {
            return
        }
        
        // 设置头像 -- placeholderImage 如果网络图像没有下载完成，就显示之前显示占位图
        iconImage.sd_setImage(with: url, placeholderImage: UIImage(named: "ad_background"))
    }
}
