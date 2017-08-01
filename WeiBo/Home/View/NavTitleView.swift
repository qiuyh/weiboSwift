//
//  NavTitleView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/19.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class NavTitleView: UIButton {

    lazy var  bgView = UIView()
    fileprivate lazy var isFirst : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 19)
        setTitleColor(UIColor.black, for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        
        sizeToFit()

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x -= 10
        imageView?.frame.origin.x  = (titleLabel?.frame.maxX)! + 5
        
        if isFirst {
            bgView.frame = CGRect(x: -2, y: -3, width: frame.size.width+10, height: frame.size.height + 6)
            bgView.backgroundColor = UIColor.lightGray
            bgView.layer.cornerRadius = 2
            bgView.clipsToBounds = true
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
            bgView.alpha = 0.3
            insertSubview(bgView, at: 0)
            bgView.isHidden = true
        }
        
        isFirst = false
    }
}
