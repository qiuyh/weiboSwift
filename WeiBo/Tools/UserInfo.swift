//
//  UserInfo.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class UserInfo: NSObject,NSCoding {
    
    static let shareInstance : UserInfo = {
        
        let userPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = (userPath as NSString).appendingPathComponent("user.plist")
//        print(path)
        let user = NSKeyedUnarchiver.unarchiveObject(withFile: path)
        
//        print(user)
        return user == nil ? UserInfo():user as! UserInfo
    }()
    
    var userPath : String?{
        let userPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (userPath as NSString).appendingPathComponent("user.plist")
    }
    
    var isLogin : Bool?
    
    var access_token : String?
    var expires_in   : String?
    var remind_in    : String?
    var uid          : String?
    
    var descrip         : String?
    var screen_name     : String?
    var avatar_large    : String?
    var followers_count : intmax_t?
    var friends_count   : intmax_t?
    var statuses_count  : intmax_t?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
    }

    override init() {
        super.init()
        isLogin = false
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(isLogin, forKey: "isLogin")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(remind_in, forKey: "remind_in")
        aCoder.encode(uid, forKey: "uid")
        
        aCoder.encode(descrip, forKey: "descrip")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(followers_count, forKey: "followers_count")
        aCoder.encode(friends_count, forKey: "friends_count")
        aCoder.encode(statuses_count, forKey: "statuses_count")
    }
    
    required init?(coder aDecoder: NSCoder) {
        isLogin      = aDecoder.decodeObject(forKey: "isLogin") as! Bool?
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String?
        expires_in   = aDecoder.decodeObject(forKey: "expires_in") as! String?
        remind_in    = aDecoder.decodeObject(forKey: "remind_in") as! String?
        uid          = aDecoder.decodeObject(forKey: "uid") as! String?
        
        descrip         = aDecoder.decodeObject(forKey: "descrip") as! String?
        screen_name     = aDecoder.decodeObject(forKey: "screen_name") as! String?
        avatar_large    = aDecoder.decodeObject(forKey: "avatar_large") as! String?
        followers_count = aDecoder.decodeObject(forKey: "followers_count") as! intmax_t?
        friends_count   = aDecoder.decodeObject(forKey: "friends_count") as! intmax_t?
        statuses_count  = aDecoder.decodeObject(forKey: "statuses_count") as! intmax_t?
    }
    
}



