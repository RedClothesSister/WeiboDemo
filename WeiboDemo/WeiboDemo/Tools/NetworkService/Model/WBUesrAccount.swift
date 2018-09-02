//
//  WBUesrAccount.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/9/2.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

private let fileName = "userAccount.json"

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
    
    override init() {
        super.init()
        
        // 从磁盘加载保存的文件
        let jsonPath = WBGetFilePath.getFilePath(fileName: fileName)
        guard let data = NSData(contentsOfFile: jsonPath),
        let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
            return
        }
        // 用于字典设置属性值
        self.yy_modelSet(with: dict ?? [:])
       
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
        
        WBGetFilePath.writeFileToDisk(dict: dict, fileName: fileName)
        
        ///Users/huangjunwei/Library/Developer/CoreSimulator/Devices/78F3FCA0-4317-457E-A978-5E6BAB9FC492/data/Containers/Data/Application/2CEC05A6-3380-493A-B9E5-BA8CC3021953/Documents/userAccount.json
    }
}
