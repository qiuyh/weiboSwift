//
//  VerticalTitleButton.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/16.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class VerticalTitleButton: UIButton {


    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片
        imageView?.center.x = frame.size.width * 0.5;
        imageView?.center.y = frame.size.height * 0.8;

    
        // 调整文字
        titleLabel?.center.x = frame.size.width * 0.5;
        titleLabel?.center.y = frame.size.height * 0.3;
        
    }
}
