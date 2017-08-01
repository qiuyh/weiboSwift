//
//  PublishViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    fileprivate lazy var topImageView : UIImageView = UIImageView()
    fileprivate var imageArray = ["publish-video","publish-picture","publish-text","publish-audio","publish-review","publish-offline"]
    fileprivate var titleArray = ["发视频", "发图片", "发段子", "发声音", "审帖", "离线下载"]
    
    fileprivate lazy var buttonArray  : [VerticalButton] = [VerticalButton]()
    fileprivate lazy var buttonFrames : [CGRect] = [CGRect]()
    fileprivate lazy var topImageViewFrame : CGRect = CGRect()
    fileprivate lazy var cancelButton : UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.groupTableViewBackground.withAlphaComponent(0.98)
        
        addTopImageView()
        addButtom()
        addCancelView()
        show()
    }
     //#MARK: - 添加标语
    fileprivate func addTopImageView(){
        topImageView.frame = CGRect(x: 0, y: 90, width: SCREENWITH, height: 70)
        topImageView.image = UIImage(named: "app_slogan")
        topImageView.sizeToFit()
        topImageView.center.x = SCREENWITH * 0.5
        
        topImageViewFrame = topImageView.frame
        topImageView.frame.origin.y -= SCREENHEIGHT
        
        view.addSubview(topImageView)
    }
    
     //#MARK: - 添加六个按钮
     fileprivate func addButtom(){
        
        let btnWith:CGFloat   = 75
        let btnHeight:CGFloat = 140
        
        let w = SCREENWITH - CGFloat(15 * 2) - CGFloat(btnWith * 3)
        let space = w * 0.5
        
        for i in 0..<imageArray.count {
            let button = VerticalButton(type: .custom)
            button.setImage(UIImage(named: imageArray[i]), for: .normal)
            button.setTitle(titleArray[i], for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.tag = 100 + i
            button.frame = CGRect(x:15 + CGFloat(i%3) * (space + btnWith), y: 170 + CGFloat(i/3 * Int(btnHeight)), width: btnWith, height: btnHeight)
                
            button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            
            buttonArray.append(button)
            buttonFrames.append(button.frame)
            
            button.frame.origin.y -= SCREENHEIGHT
            
            view.addSubview(button)
        }
    }
    //#MARK: - 添加取消按钮
    fileprivate func addCancelView(){
        cancelButton.frame = CGRect(x: 0, y: SCREENHEIGHT - 49, width: SCREENWITH, height: 49)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .highlighted)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        
        view.addSubview(cancelButton)
    }
    
     //#MARK: - 动画显示
    fileprivate func show(){
        
        UIView.animate(withDuration: 1.0, delay:0 , usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options:[], animations: {
            self.topImageView.frame = self.topImageViewFrame
            
            }, completion:nil)

        let array = [buttonArray[4],buttonArray[3],buttonArray[5],buttonArray[1],buttonArray[0],buttonArray[2]]
        let frame = [buttonFrames[4],buttonFrames[3],buttonFrames[5],buttonFrames[1],buttonFrames[0],buttonFrames[2],]
        
        
        for i in 0..<array.count {
            
            let btn = array[i]
            var delayTime:CGFloat = 0.1
            
            switch i {
            case 0:delayTime = 0.15
            case 1,2:delayTime = 0.25
            case 3:delayTime = 0.25
            case 4,5:delayTime = 0.35
            default:delayTime = 0.45
                
            }
            
            UIView.animate(withDuration: 0.4, delay:TimeInterval(delayTime) , usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options:.curveEaseIn, animations: {
                btn.frame = frame[i]
                
                }, completion:nil)
        }

    }
     //#MARK: - 动画隐藏
    fileprivate func dismiss(){
        
        UIView.animate(withDuration: 0.1) {
            self.cancelButton.frame.origin.y = SCREENHEIGHT * 1.1
        }
        
        UIView.animate(withDuration: 0.5, delay:0.3 , usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options:[], animations: {
            self.topImageView.frame.origin.y = SCREENHEIGHT * 1.1
            
            }, completion:nil)
        
        
        let array = [buttonArray[4],buttonArray[3],buttonArray[5],buttonArray[1],buttonArray[0],buttonArray[2]]

        for i in 0..<array.count {
            
            let btn = array[i]
            var delayTime:CGFloat = 0.1
            
            switch i {
            case 0:delayTime = 0.1
            case 1,2:delayTime = 0.25
            case 3:delayTime = 0.25
            case 4,5:delayTime = 0.35
            default:delayTime = 0.4
                
            }
            
            UIView.animate(withDuration: 0.3, delay:TimeInterval(delayTime) , usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options:.curveEaseInOut, animations: {
                btn.frame.origin.y = SCREENHEIGHT * 1.1
                
                }, completion:{ (finished) in
                    
                    if i == array.count - 1{
                        window_.isHidden = true
                        window_.rootViewController = nil
                    }
            })
            
        }
    }
    
     //#MARK: - 点击事件
    
    @objc fileprivate func clickButton(){
        
    }
    
    @objc fileprivate func clickCancel(){
       dismiss()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }

   
}
