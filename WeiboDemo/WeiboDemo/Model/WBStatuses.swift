//
//  WBStatuses.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/30.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import YYModel

// 微博数据模型
class WBStatuses: NSObject {
    // 微博ID
    @objc var id: Int64 = 0
    // 微博信息内容
    @objc var text: String?
    
    // 重写description 的计算型属性
    override var description: String {
        return yy_modelDescription()
    }
}
