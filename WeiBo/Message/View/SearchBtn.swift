//
//  SearchBtn.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/24.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class SearchBtn: UIButton {

    lazy var  bgView = UIView()
    fileprivate lazy var isFirst : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        setImage(UIImage(named: "searchbar_second_textfield_search_icon"), for: .normal)
        setTitleColor(UIColor.lightGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        layer.cornerRadius = 3
        clipsToBounds = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame = CGRect(x: 5, y: 5, width: SCREENWITH - 10, height: 30)
        
        titleLabel?.frame.origin.x  = (imageView?.frame.maxX)! + 10
        
    }

}
