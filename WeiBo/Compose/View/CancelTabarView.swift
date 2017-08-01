//
//  CancelTabarView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class CancelTabarView: UIView {

    fileprivate lazy var cancelImageView  : UIImageView = UIImageView()
    fileprivate lazy var leftArrowButton : UIButton = UIButton(type: .custom)
    fileprivate lazy var lineView : UIView = UIView()
    
    var isShowArrow :Bool? {
         didSet {
            exchangeView()
        }
    }
    
    var retureCallBack : ((Void) -> (Void))?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initCancelImageView()
        initLeftArrowButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 初始化取消➕imageView

extension CancelTabarView{
    fileprivate func initCancelImageView(){
        
        cancelImageView.image = UIImage(named: "tabbar_compose_background_icon_close")
        cancelImageView.sizeToFit()
        cancelImageView.isUserInteractionEnabled = true
        cancelImageView.center = CGPoint(x: center.x, y: frame.size.height*0.5)
        //旋转成➕字
        transformFrome()
        
        backgroundColor = UIColor.white
        addSubview(cancelImageView)
    }
}

//MARK:-左边返回箭头按钮和中间分割线
extension CancelTabarView{
    fileprivate func initLeftArrowButton(){
        leftArrowButton.frame = CGRect(x: 0, y: 0, width: SCREENWITH*0.5-0.5, height: 49)
        leftArrowButton.setImage(UIImage(named: "tabbar_compose_background_icon_return"), for: .normal)
        leftArrowButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        addSubview(leftArrowButton)
        
        lineView = UIView(frame: CGRect(x: SCREENWITH*0.5, y: 0, width: 1, height: 49))
        lineView.backgroundColor = UIColor.lightGray
        
        addSubview(lineView)
    }
}

//返回按钮事件

extension CancelTabarView{
    @objc fileprivate func back(){
        
        if retureCallBack != nil {
            retureCallBack!()
        }
    }
}

//MARK:-通过isShowArrow隐藏、显示View和调整cancelImageView的位置

extension CancelTabarView{
    fileprivate func exchangeView(){
//        print("exchangeView")
        if isShowArrow! {
            cancelImageView.center = CGPoint(x: center.x*1.5+0.5, y: frame.size.height*0.5)
            leftArrowButton.isHidden = false
            lineView.isHidden = false
            
        }else{
            cancelImageView.center = CGPoint(x: center.x, y: frame.size.height*0.5)
            leftArrowButton.isHidden = true
            lineView.isHidden = true
        }
    }
}

//MARK:-cancelImageView旋转事件
extension CancelTabarView{
    func transformTo(){
        cancelImageView.transform = cancelImageView.transform.rotated(by: (CGFloat)(M_PI_4))
    }
    
    func transformFrome(){
         cancelImageView.transform = cancelImageView.transform.rotated(by: -(CGFloat)(M_PI_4))
    }
}

//MARK:-把上个界面传来的闭包赋值给本View的闭包

extension CancelTabarView{
    func cancelCallBackBlock(block:@escaping ()->(Void)){
        retureCallBack = block
    }

}


