//
//  WBUesrAccount.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/9/2.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

// 用户账户信息
class WBUesrAccount: NSObject {
    
    // 访问令牌
    @objc var access_token: String?
    
    // 用户代号
    @objc var uid: String?
    
    //过期日期
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            // 将过期日期的秒数转化为 标准日期
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    @objc var expiresDate: Date?
    
    override var description: String {
        return yy_modelDescription()
    }
}
