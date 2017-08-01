//
//  SubscribeModel.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class SubscribeModel: NSObject,NSCoding {
    
    var theme_id   : String?
    var theme_name : String?
    var image_list : String?
    var sub_number : String?
    

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override init() {
        super.init()
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        theme_id   = aDecoder.decodeObject(forKey: "theme_id")   as! String?
        theme_name = aDecoder.decodeObject(forKey: "theme_name") as! String?
        image_list = aDecoder.decodeObject(forKey: "image_list") as! String?
        sub_number = aDecoder.decodeObject(forKey: "sub_number") as! String?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(theme_id  , forKey: "theme_id")
        aCoder.encode(theme_name, forKey: "theme_name")
        aCoder.encode(image_list, forKey: "image_list")
        aCoder.encode(sub_number, forKey: "sub_number")
    }
}
