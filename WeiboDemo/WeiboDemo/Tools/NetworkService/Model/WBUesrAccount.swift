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
    
    /*
     * 偏好设置(存储小数据)
     * 沙盒存储 - 归档/plist/json
     * 数据库(FMDB/CoreData)
     * 钥匙串访问(存储小数据) 可以保存二进制数据 - 需要使用框架 SSKeychain
    */
    
    func saveAccountToDisk() {
        
        // 1.模型转字典
        var dict = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
        // 需要移除 expires_in
        dict.removeValue(forKey: "expires_in")
        
        // 2.字典序列化Data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return
        }
        
        // 3.写入磁盘
        // 获取本地的沙盒路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileName = "userAccount.json"
        let jsonPath = (docDir as NSString).appendingPathComponent(fileName)
        (data as NSData).write(toFile: jsonPath, atomically: true)
        print("用户信息文件已经保存，保存路径如下：")
        print(jsonPath)
        ///Users/huangjunwei/Library/Developer/CoreSimulator/Devices/78F3FCA0-4317-457E-A978-5E6BAB9FC492/data/Containers/Data/Application/2CEC05A6-3380-493A-B9E5-BA8CC3021953/Documents/userAccount.json
    }
}
