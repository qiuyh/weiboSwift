//
//  UIColor-Extension.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorWithHexString(hexString: String) -> UIColor {
        
        var color = UIColor.red
        var cStr : String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = cStr.substring(from: index)
        }
        if cStr.characters.count != 6 {
            return UIColor.black
        }
        //两种不同截取字符串的方法
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = cStr.substring(with: rRange)
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = cStr.substring(with: gRange)
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = cStr.substring(from: bIndex)
        
        color = UIColor.init(colorLiteralRed: Float(changeToInt(numStr: rStr)) / 255, green: Float(changeToInt(numStr: gStr)) / 255, blue: Float(changeToInt(numStr: bStr)) / 255, alpha: 1)
        return color
    }

}

func changeToInt(numStr:String) -> Int {
    
    let str = numStr.uppercased()
    var sum = 0
    for i in str.utf8 {
        //0-9 从48开始
        sum = sum * 16 + Int(i) - 48
        if i >= 65 {
            //A~Z 从65开始，但初始值为10
            sum -= 7
        }
    }
    return sum
}


