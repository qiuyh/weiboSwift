//
//  VerticalButton.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/14.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片
        imageView?.frame.origin.x = 0;
        imageView?.frame.origin.y = 0;
        imageView?.frame.size.width  = frame.size.width;
        imageView?.frame.size.height = (imageView?.frame.size.width)!;
        
        // 调整文字
        titleLabel?.frame.origin.x = 0;
        titleLabel?.frame.origin.y = (imageView?.frame.size.height)!;
        titleLabel?.frame.size.width  = frame.size.width;
        titleLabel?.frame.size.height = frame.size.height - (titleLabel?.frame.origin.y)!;
        
        titleLabel?.textAlignment = .center

    }
}
