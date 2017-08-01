//
//  UserViewModel.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/18.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class UserViewModel{

    static let shareInstance : UserViewModel = UserViewModel()
    
    var user : UserInfo?
    
    // MARK:- 计算属性
    var userPath : String {
        let userPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (userPath as NSString).appendingPathComponent("account.plist")
    }
    
     init () {
        // 1.从沙盒中读取中归档的信息
        
        let userun = NSKeyedUnarchiver.unarchiveObject(withFile: userPath)
        
        user = userun == nil ?  UserInfo() : userun as! UserInfo
    }
    
}
