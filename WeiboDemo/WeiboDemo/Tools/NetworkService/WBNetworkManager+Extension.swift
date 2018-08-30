//
//  WBNetworkManager+Extension.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/29.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import Foundation

extension WBNetworkManager {
    
    func statuses(completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        // 用AFN网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00heeKrFSw4QDB874ca1a2abuDmXuB"]
        
        // 网络请求
        request(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            //print(json)
            // 从json中获取字典数组  如果 as？失败，result为nil
            let result = (json as! NSDictionary)["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
    }
}
