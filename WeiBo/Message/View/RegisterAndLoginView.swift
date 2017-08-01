//
//  RegisterAndLoginView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class RegisterAndLoginView: UIView {
    
    fileprivate lazy var textLabel   : UILabel  = UILabel()
    fileprivate lazy var registerBtn : UIButton = UIButton(type: .system)
    fileprivate lazy var loginBtn    : UIButton = UIButton(type: .system)
    
    fileprivate var loginBlock : ((Void) -> (Void))?
    fileprivate var registerBlock : ((Void) -> (Void))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupView(){
        
        backgroundColor = UIColor.colorWithHexString(hexString: "#EEEEEE")
        
        textLabel.frame = CGRect(x: 45, y:frame.origin.y == 0 ? 70 : 0, width: SCREENWITH - 90, height: 42)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.lightGray
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.text = frame.origin.y == 0 ? "登陆后，你的微博、相册、个人资料会显示在这里，展示给别人":"登陆后，别人评论你的微博，给你发消息，都会在这里收到通知"
        //登陆后，你的微博、相册、个人资料会显示在这里，展示给别人
        textLabel.numberOfLines = 2;
        
        
        setupBtn(button: registerBtn, title: "注册", color: UIColor.orange, isRegiser: true)
        setupBtn(button: loginBtn, title: "登录", color: UIColor.gray, isRegiser: false)
        
        
        addSubview(textLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
    
    }
    
    
    
    fileprivate func setupBtn(button:UIButton, title:String ,color:UIColor ,isRegiser:Bool){
        
        button.frame = CGRect(x: 0, y:textLabel.frame.maxY + 20, width: 120, height: 35)
        button.layer.cornerRadius = 3;
        button.clipsToBounds = true
        button.layer.borderWidth = 0.4;
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        
        if isRegiser {
            button.center.x = center.x - 10 - button.frame.size.width * 0.5
            button.addTarget(self, action: #selector(gotoRegister), for: .touchUpInside)
        }else{
            button.center.x = center.x + 10 + button.frame.size.width * 0.5
            button.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
        }
    }
    
    @objc fileprivate func gotoRegister(){
        if registerBlock != nil {
            registerBlock!()
        }
    }
    
    @objc fileprivate func gotoLogin(){
        if loginBlock != nil {
            loginBlock!()
        }
    }
    
    func setLoginBlock(block: @escaping (Void) -> (Void)) {
        loginBlock = block
    }

    func setRigisterBlock(block: @escaping (Void) -> (Void)) {
        registerBlock = block
    }
}


