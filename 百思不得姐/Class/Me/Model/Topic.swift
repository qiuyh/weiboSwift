//
//  Topic.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/11.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class Topic: NSObject {

    var ID      : Int?
    var name    : String?
    var count   : Int?
    
    var next_page  : Int = 1
    var total_page : Int = 1
    var list : [Content] = [Content]()
    var contentOffsetY : CGFloat = -64
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    func replacedKeyFromPropertyName() -> NSDictionary{
        return [ID:"id"]
    }
}
