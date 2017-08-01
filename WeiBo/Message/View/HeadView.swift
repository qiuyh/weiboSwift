//
//  HeadView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/24.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class HeadView: UIView {

    fileprivate lazy var searchBtn : UIButton = UIButton(type: .custom)
    var title :String?{
        didSet{
            searchBtn.setTitle(title, for: .normal)
        }
    }
    var isCenter : Bool?{
        didSet{
            
            if isCenter! {
                searchBtn.contentHorizontalAlignment = .center;            }

        }
    }
    
    fileprivate var presentVCBlock : ((Void) -> (Void))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        title = "搜索联系人和群"
        isCenter = false
        setupSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

      fileprivate func setupSubView(){
        
        frame = CGRect(x: 0, y: 0, width: SCREENWITH, height: 40)
        backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1.0)
        
        searchBtn.backgroundColor = UIColor.white
        searchBtn.frame = CGRect(x: 5, y: 5, width: SCREENWITH - 10, height: 30)
        searchBtn.setImage(UIImage(named: "searchbar_second_textfield_search_icon"), for: .normal)
        searchBtn.setTitleColor(UIColor.lightGray, for: .normal)
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        searchBtn.layer.cornerRadius = 3
        searchBtn.clipsToBounds = true

        searchBtn.setTitle(title, for: .normal)
        searchBtn.addTarget(self, action: #selector(searAction), for: .touchUpInside)
        searchBtn.contentHorizontalAlignment = .left;

        searchBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        searchBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        addSubview(searchBtn)

    }

}

extension HeadView {
    
    @objc fileprivate func searAction(){
       
        if presentVCBlock != nil {
            presentVCBlock!()
        }
    }
    
    func present(block: @escaping (Void) -> ()){
        presentVCBlock = block
    }
}


