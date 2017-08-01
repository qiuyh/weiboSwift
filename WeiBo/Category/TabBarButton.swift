//
//  TabBarButton.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class TabBarButton: UIButton {
    
    var imageViewY  : CGFloat = 0.0
    var titleLabelY : CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViewY  = (imageView?.frame.origin.y)!
        titleLabelY = (titleLabel?.frame.origin.y)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        titleLabel?.frame.origin.x -= 10
        imageView?.center.x    = frame.size.width * 0.5
        titleLabel?.center.x   = frame.size.width * 0.5
        imageView?.frame.origin.y  = imageViewY  - 4
        titleLabel?.frame.origin.y = titleLabelY + 13
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
