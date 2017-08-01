//
//  ComposeView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class ComposeView: UIScrollView {
    
    fileprivate lazy var titleArray : Array = ["文字","照片/视频","头条文章","签到","直播","更多","点评","好友圈","音乐","红包","商品","秒拍"]
    fileprivate lazy var imageNameNormolArray :Array = ["tabbar_compose_idea","tabbar_compose_photo","tabbar_compose_headlines","tabbar_compose_lbs","tabbar_compose_video","tabbar_compose_more","tabbar_compose_review","tabbar_compose_friend","tabbar_compose_music","tabbar_compose_envelope","tabbar_compose_productrelease","tabbar_compose_shooting"]
    fileprivate lazy var imageNameHightlArray :Array = ["tabbar_compose_idea_h","tabbar_compose_photo_h","tabbar_compose_headlines_h","tabbar_compose_lbs_h","tabbar_compose_video_h","tabbar_compose_more_h","tabbar_compose_review_h","tabbar_compose_friend_h","tabbar_compose_music_h","tabbar_compose_envelope_h","tabbar_compose_productrelease_h","tabbar_compose_shooting_h"]
    
    fileprivate lazy var buttonArrays   : NSMutableArray = NSMutableArray()
    fileprivate lazy var btnFrameArrays : NSMutableArray = NSMutableArray()
    
    var arrowCallBack : ((_ isShowArrow:Bool) -> (Void))?
    
    var presentVCCallBack : ((Void) -> (Void))?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ComposeView{
    
    fileprivate func setupUI(){
        backgroundColor = UIColor.clear
        contentSize = CGSize(width: frame.size.width*2, height: frame.size.height)
        bounces = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        isScrollEnabled = false
        delegate = self
    }
}


//MARK:- 加载Button
extension ComposeView{
    fileprivate func setupSubviews() {
        for i in 0..<titleArray.count {
            let button = UIButton(type: .custom)
            let label = UILabel()
            
            let with   = SCREENWITH/3.0
            let height = with+20
            let x1 = SCREENWITH*(CGFloat)(i/6)
            let x2 = with*(CGFloat)(i%3)
            let x  = x1+x2
            let y  = height*(CGFloat)((i%6)/3)+50
            
            
            button.frame = CGRect(x: x, y: y, width: with, height: height)
            button.setImage(UIImage(named:imageNameNormolArray[i]), for: .normal)
            button.setImage(UIImage(named:imageNameHightlArray[i]), for: .highlighted)
//            button.setTitle(titleArray[i], for: .normal)
//            button.setTitleColor(UIColor.init(colorLiteralRed: 65/255.0, green: 65/255.0, blue: 65/255.0, alpha: 1.0), for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//            button.imageEdgeInsets = UIEdgeInsets(top: -25, left: 10, bottom: 0, right: 0)
//            button.titleEdgeInsets = UIEdgeInsets(top: 80, left: -70, bottom: 0, right: 0)
            button.tag = i
            button.addTarget(self, action: #selector(coposeBtnAction), for: .touchUpInside)
//            button.sizeToFit()
            
            let x3 = (1+(CGFloat)(i%3))
            switch x3 {
            case 1:
                button.center.x = (SCREENWITH/5.0)+x1
            case 2:
                button.center.x = (SCREENWITH/2.0)+x1
            case 3:
                button.center.x = (SCREENWITH/5.0)*4+x1
            default: break
                
            }

            
           
            label.text = titleArray[i]
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.init(colorLiteralRed: 65/255.0, green: 65/255.0, blue: 65/255.0, alpha: 1.0)
            label.textAlignment = .center
//            print("\(button.center.x/2.0)")
            label.sizeToFit()
            label.center = CGPoint(x: with/2.0, y: height-10)
    
            button.addSubview(label)
            addSubview(button)
            
            btnFrameArrays.add(button.frame)
            buttonArrays.add(button)
            
            button.frame.origin.y += frame.size.height
        }
    }
}

//MARK:- 显示隐藏动画
extension ComposeView{
     func showAnimateBtn(){
        for i in 0..<12 {
            let btn:UIButton = buttonArrays[i] as! UIButton
            
            let delayTime:CGFloat = 0.05*(CGFloat)(i%3)+0.05
//            print("\(delayTime)")
            UIView.animate(withDuration: 0.5, delay:TimeInterval(delayTime) , usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options:[], animations: {
                btn.frame = self.btnFrameArrays[i] as! CGRect
                
                }, completion: nil)
        }
    }
    
    func hideAnimateBtn(){
        for i in 0..<12 {
            let btn:UIButton = buttonArrays[i] as! UIButton
            
            let delayTime:CGFloat = 0.05*(CGFloat)(3-i%3)
            //            print("\(delayTime)")
            UIView.animate(withDuration: 0.8, delay:TimeInterval(delayTime) , usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options:[], animations: {
                btn.frame.origin.y += self.frame.size.height
                
                }, completion: nil)
        }
    }

}

//MARK:- action
extension ComposeView{
    @objc fileprivate func coposeBtnAction(button:UIButton){
        
        switch button.tag {
        case 5:
            setContentOffset(CGPoint(x: SCREENWITH, y: 0), animated: true)
        break
            
        default:
            UIView .animate(withDuration: 0.2, animations: {
                button.transform = button.transform.scaledBy(x: 2.0, y: 2.0)
                button.alpha = 0.0
                
            }) { (_) in
                if self.presentVCCallBack != nil {
                    self.presentVCCallBack!()
                    self.isHidden = true
                }
            }
            
        break
            
        }
        
        print("\(button.tag)")
    }
}


//MARK:- UIScrollViewDelegate方法

extension ComposeView:UIScrollViewDelegate{
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndScrollingAnimation")
        if contentOffset.x > SCREENWITH*0.5 {
            isScrollEnabled = true
            if arrowCallBack != nil {
                arrowCallBack!(true)
            }
        }else{
            isScrollEnabled = false
            if arrowCallBack != nil {
                arrowCallBack!(false)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
        if contentOffset.x > SCREENWITH*0.5 {
            isScrollEnabled = true
            if arrowCallBack != nil {
                arrowCallBack!(true)
            }
        }else{
            isScrollEnabled = false
            if arrowCallBack != nil {
                arrowCallBack!(false)
            }
        }

    }

}


//MARK:-把上个界面传来的闭包赋值给本View的闭包
extension ComposeView{
    func callBackBlock(block: @escaping (_ isShow: Bool) -> Void) {
        
        arrowCallBack = block
    }

    func presentVCBlock(block:@escaping () -> (Void)) {
        presentVCCallBack = block
    }
}




