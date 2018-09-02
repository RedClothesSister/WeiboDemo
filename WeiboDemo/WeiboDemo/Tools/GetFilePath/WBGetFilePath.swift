//
//  WBGetFilePath.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/9/2.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBGetFilePath: NSObject {

    // 获取文件路径
    static func getFilePath(fileName: String) -> String {
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent(fileName)
        
        return jsonPath
    }
    
    
    // 写入文件
    static func writeFileToDisk(dict: [String: AnyObject], fileName: String) {
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return
        }
        
        let jsonPath = WBGetFilePath.getFilePath(fileName: fileName)
        (data as NSData).write(toFile: jsonPath, atomically: true)
    }
    
}
