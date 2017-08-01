//
//  StatusModel.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/25.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class StatusModel: NSObject {
    
    //MARK: 微博对应的微博//statuses
    var mid :String = "0"                   // 微博的ID
    var created_at : String?                // 微博创建时间
    var source : String?                    // 微博来源
    var text : String?                      // 微博的正文
    var pic_urls : [[String : String]]?     // 微博的配图
    var reposts_count   : Int = 0           // 转发数
    var comments_count  : Int = 0           // 评论数
    var attitudes_count : Int = 0           // 表态数
    
    //MARK: 微博对应的微博//user
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    var verified_type : Int = -1            // 用户的认证类型
    var mbrank : Int = 0                    // 用户的会员等级

    
    //MARK: 微博对应的转发的微博//retweeted_status
    var retweeted_screen_name : String?
    var retweeted_text : String?
    var retweeted_pic_urls : [[String : String]]?
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        mid        = dict["mid"] as! String
        created_at = dict["created_at"] as? String
        source     = dict["source"] as? String
        text       = dict["text"] as? String
        pic_urls   = dict["pic_urls"] as? [[String : String]]
        reposts_count   = dict["reposts_count"] as! Int
        comments_count  = dict["comments_count"] as! Int
        attitudes_count = dict["attitudes_count"] as! Int
        
        let userDic = dict["user"] as? [String : Any]
        if let user = userDic {
             profile_image_url = user["profile_image_url"] as? String
             screen_name       = user["screen_name"] as? String
             verified_type     = user["verified_type"] as! Int
             mbrank            = user["mbrank"] as! Int
        }
        
        
        let retweeted_statusDic = dict["retweeted_status"] as? [String : Any]
        if let retweeted_status = retweeted_statusDic {
            
            let retweeted_userDic = retweeted_status["user"] as? [String : Any]
            if let retweeted_user = retweeted_userDic {
                retweeted_screen_name = retweeted_user["screen_name"] as? String
            }
            
            retweeted_text        = retweeted_status["text"] as? String
            retweeted_pic_urls    = retweeted_status["pic_urls"] as? [[String : String]]
        }
       
    }


}
