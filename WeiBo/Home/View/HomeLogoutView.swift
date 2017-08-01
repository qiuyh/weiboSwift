//
//  HomeLogoutView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class HomeLogoutView: UIView {
    
    fileprivate lazy var rotationView : UIImageView = UIImageView()
    fileprivate lazy var bgView       : UIImageView = UIImageView()
    fileprivate lazy var iconView     : UIImageView = UIImageView()
    fileprivate lazy var textLabel    : UILabel     = UILabel()
    fileprivate lazy var attentionBtn : UIButton    = UIButton(type:.system)
    
    var attentionBlock : ((Void) -> (Void))?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupSubViews(){
        
        backgroundColor = UIColor.colorWithHexString(hexString: "#EEEEEE")
//        print("\(self)")
        
        rotationView.frame.size = CGSize(width: 200, height: 200)
        rotationView.center     = CGPoint(x: center.x, y: center.y*0.8)
        rotationView.image      = UIImage(named: "visitordiscover_feed_image_smallicon")
        
        bgView.frame = CGRect(x: 0, y: 0, width: SCREENWITH, height: SCREENHEIGHT/1.6)
        bgView.image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        iconView.frame.size = CGSize(width: 100, height: 100)
        iconView.center     = CGPoint(x: center.x, y: center.y*0.8)
        iconView.image      = UIImage(named: "visitordiscover_feed_image_house")
        
        textLabel.frame = CGRect(x: 0, y:iconView.frame.maxY + 50, width: SCREENWITH, height: 21)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.lightGray
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.text = "关注一些人，回这里看看有什么惊喜"
    
        attentionBtn.frame = CGRect(x: 0, y:textLabel.frame.maxY + 30, width: 120, height: 35)
        attentionBtn.center.x = center.x
        attentionBtn.layer.cornerRadius = 3;
        attentionBtn.clipsToBounds = true
        attentionBtn.layer.borderWidth = 0.4;
        attentionBtn.layer.borderColor = UIColor.lightGray.cgColor
        attentionBtn.setTitle("去关注", for: .normal)
        attentionBtn.setTitleColor(UIColor.orange, for: .normal)
        attentionBtn.addTarget(self, action: #selector(gotoAttention), for: .touchUpInside)
        
        

        addSubview(rotationView)
        addSubview(bgView)
        addSubview(iconView)
        addSubview(textLabel)
        addSubview(attentionBtn)
        
        addRotationAnim()
    }
    
    
    //点击去关注
   @objc fileprivate func gotoAttention(){
//        print("gotoAttention")
    if attentionBlock != nil {
        attentionBlock!()
    }
    }
    
    
    //添加旋转动画
    fileprivate func addRotationAnim(){
        
        let rotaionAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotaionAnim.fromValue = 0.0
        rotaionAnim.toValue = M_PI*2
        rotaionAnim.repeatCount = MAXFLOAT
        rotaionAnim.duration = 20;
        rotaionAnim.isRemovedOnCompletion = false
        
        rotationView.layer.add(rotaionAnim, forKey: "rotationView")

    }
    
    func setAttentionCallBlock(block:@escaping (Void) -> (Void)){
        attentionBlock = block
    }
    
}
