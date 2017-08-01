//
//  LoginProfileView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/17.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class LoginProfileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupView(){
        
        backgroundColor = UIColor.white
        
        let headImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        headImageView.layer.cornerRadius = headImageView.frame.size.width/2.0
        headImageView.clipsToBounds = true
        headImageView.sd_setImage(with: NSURL(string: UserInfo.shareInstance.avatar_large!) as URL?, placeholderImage: UIImage(named: "message_creategroup_portrait"))
        headImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickHeadView))
        headImageView.addGestureRecognizer(tap)
        
        
        let nameBtn = UIButton(type: .custom)
        nameBtn.setTitle(UserInfo.shareInstance.screen_name!, for: .normal)
        nameBtn.setTitleColor(UIColor.black, for: .normal)
//        nameBtn.sizeToFit()
        nameBtn.frame = CGRect(x: headImageView.frame.maxX + 5, y: 15, width: 100, height: 30)
        nameBtn.addTarget(self, action: #selector(clickNameBtn), for: .touchUpInside)
        
        let introductionLabel = UILabel(frame: CGRect(x: headImageView.frame.maxX + 5, y: nameBtn.frame.maxY, width: 120, height: 21))
        introductionLabel.text = "简介：\(UserInfo.shareInstance.descrip! == "" ? "暂无介绍":UserInfo.shareInstance.descrip!)"
//        introductionLabel.textAlignment = .center
        introductionLabel.textColor = UIColor.lightGray
        introductionLabel.font = UIFont.systemFont(ofSize: 14)
        
        let menberBtn = UIButton(type: .custom)
        menberBtn.frame = CGRect(x: SCREENWITH-90, y: 20, width: 80, height: 40)
        menberBtn.setImage(UIImage(named: "mine_icon_membership"), for: .normal)
        menberBtn.setTitle("会员", for: .normal)
        menberBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        menberBtn.setTitleColor(UIColor.orange, for: .normal)
        menberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        menberBtn.addTarget(self, action: #selector(clickmenberBtn), for: .touchUpInside)
        
        let arrowView = UIImageView()
        arrowView.image = UIImage(named: "mine_icon_membership_arrow")
        arrowView.sizeToFit()
        arrowView.center = menberBtn.center
        arrowView.center.x = menberBtn.center.x + menberBtn.frame.size.width*0.45
        
        
        let lineView = UIView(frame: CGRect(x: 0, y: headImageView.frame.maxY + 10, width: SCREENWITH, height: 0.5))
        lineView.backgroundColor = UIColor.lightGray
        lineView.alpha = 0.5

        
        
        addSubview(headImageView)
        addSubview(nameBtn)
        addSubview(introductionLabel)
        addSubview(menberBtn)
        addSubview(arrowView)
        addSubview(lineView)
        
        let countArray = ["\(UserInfo.shareInstance.statuses_count!)","\(UserInfo.shareInstance.friends_count!)","\(UserInfo.shareInstance.followers_count!)"]
        let titleArray = ["微博","关注","粉丝"]
        
        for i in 0..<3 {
            
            let btn = UIButton(frame: CGRect(x: 0, y: lineView.frame.maxY, width: 50, height: 50))
            btn.center.x = (SCREENWITH/2.0)*0.5*(CGFloat)(1+i)-(CGFloat)(1 - i)*btn.frame.size.width*0.5
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitle(countArray[i], for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
            
            let label = UILabel()
            label.frame.size = CGSize(width: btn.frame.size.width, height: 21)
            label.center.x = btn.center.x
            label.center.y = btn.center.y + 20
            label.textAlignment = .center
            label.text = titleArray[i]
            label.textColor = UIColor.lightGray
            label.font = UIFont.systemFont(ofSize: 14)
            
            
            addSubview(label)
            addSubview(btn)
        }
    }
    
    
    @objc fileprivate func clickHeadView(){
        print("clickHeadView")
    }
    
    @objc fileprivate func clickNameBtn(){
        print("clickNameBtn")
    }
    
    @objc fileprivate func clickmenberBtn(){
        print("clickmenberBtn")
    }


    @objc fileprivate func clickBtn(button: UIButton){
        
        switch button.tag {
        case 0: break
        case 1: break
        case 2: break
        default: break
            
        }
        print("\(button.tag)")
    }

}
