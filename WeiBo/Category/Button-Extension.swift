//
//  Button-Extension.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(imageName:String, bgImageName:String) {
        self.init()
        if imageName != "" {
            setImage(UIImage(named: imageName), for: .normal)
            setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        }
        
        if bgImageName != "" {
            setBackgroundImage(UIImage(named: bgImageName), for: .normal)
            setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        }
        
        sizeToFit()
    }
    
    
    convenience init(normalImageName:String, highlightedImageName:String, title:String, titleColor:UIColor, font:CGFloat) {
        self.init()

        setImage(UIImage(named: normalImageName), for: .normal)
        setImage(UIImage(named: highlightedImageName), for: .highlighted)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: font)
        
        sizeToFit()
    }
    
    convenience init(normalImageName:String, highlightedImageName:String, targer:Any?, action:Selector){
        self.init()
        
        setImage(UIImage(named: normalImageName), for: .normal)
        setImage(UIImage(named: highlightedImageName), for: .highlighted)
        sizeToFit()
        addTarget(targer, action: action, for: .touchUpInside)
    }
    
}


