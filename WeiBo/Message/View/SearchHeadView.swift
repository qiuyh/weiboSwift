//
//  SearchHeadView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/24.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class SearchHeadView: UIView {

    fileprivate lazy var searchImageView : UIImageView = UIImageView()
    lazy var searchTextField : UITextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupSubView(){
        
        backgroundColor = UIColor.init(colorLiteralRed: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        layer.cornerRadius = 5
        clipsToBounds = true
        
        searchImageView.image = UIImage(named: "searchbar_second_textfield_search_icon")
        searchImageView.sizeToFit()
        searchImageView.frame.origin.x = 10
        searchImageView.center.y = center.y
        
        searchTextField.frame = CGRect(x: 35, y: 5, width: frame.size.width - 35, height: 25)
        searchTextField.borderStyle = .none
//        searchTextField.placeholder = "搜索联系人和群"
        searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchTextField.center.y = center.y
        
        addSubview(searchImageView)
        addSubview(searchTextField)
        
        searchTextField.becomeFirstResponder()

    }
    
    
}
