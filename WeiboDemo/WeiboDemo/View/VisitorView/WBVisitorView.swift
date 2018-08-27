//
//  WBVisitorView.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/27.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

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
    }
}
