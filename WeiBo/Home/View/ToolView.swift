//
//  ToolView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/7.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class ToolView: UIView {

    lazy var retweetedButton = UIButton(type: .custom)
    lazy var commentButton = UIButton(type: .custom)
    lazy var supportButton = UIButton(type: .custom)
    fileprivate lazy var buttonsArray : [UIButton] = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton()
        addBottomView()
    }
    
    fileprivate func addButton(){
        
//        backgroundColor = UIColor.red
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 0.5
        
        buttonsArray = [retweetedButton,commentButton,supportButton]
        
        let imageArray = ["timeline_icon_retweet","timeline_icon_comment","timeline_icon_unlike"]
        
        for i in 0..<imageArray.count {
            let  button = buttonsArray[i]
            button.tag = 100 + i
            button.frame = CGRect(x: CGFloat(i) * SCREENWITH / 3.0, y: 0, width: SCREENWITH/3.0, height: frame.size.height - 0.5)
            button.setImage(UIImage(named: imageArray[i]), for: .normal)
            button.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
//            button.setTitle("8755", for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.titleLabel?.font  = UIFont.systemFont(ofSize: 12)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            button.titleEdgeInsets   = UIEdgeInsetsMake(0, 10, 0, 0)
            
            if i != imageArray.count {
                let imageView = UIImageView(frame: CGRect(x:button.frame.maxX , y: 2, width: 0.5, height: frame.size.height - 4.5))
                imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
                imageView.alpha = 0.6
                
                addSubview(imageView)
            }
            
            addSubview(button)
        }
    }
    
    fileprivate func addBottomView(){
        
        let bottomView = UIView(frame: CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 15))
        bottomView.backgroundColor = UIColor.groupTableViewBackground
        
        addSubview(bottomView)
        
    }
    
    @objc fileprivate func clickBtn(button : UIButton){
        
        print(button.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
