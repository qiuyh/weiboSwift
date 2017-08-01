//
//  String-Extension.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/31.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import Foundation


extension String{
    
   func getSizeByString(string:String,fontSize:CGFloat,maxSize:CGSize) -> CGSize{
    
       return (string as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }

}
