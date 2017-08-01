//
//  MessageLogoutView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class MessageLogoutView: UIView {
    
    fileprivate lazy var iconImageView : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    fileprivate func setupLayoutSubviews() {
       backgroundColor = UIColor.colorWithHexString(hexString: "#EEEEEE")
        
        iconImageView.frame.size = CGSize(width: 200, height: 200)
        iconImageView.center     = CGPoint(x: center.x, y: center.y*0.8)
        iconImageView.image      = UIImage(named: "visitordiscover_image_message")
    
        addSubview(iconImageView)
    }
}
