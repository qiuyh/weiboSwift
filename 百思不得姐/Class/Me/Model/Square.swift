//
//  Square.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class Square: NSObject,NSCoding {

    var icon : String?
    var name : String?
    var url  : String?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        icon = aDecoder.decodeObject(forKey: "icon") as! String?
        name = aDecoder.decodeObject(forKey: "name") as! String?
        url  = aDecoder.decodeObject(forKey: "url")  as! String?
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(url,  forKey: "url")
    }

}
