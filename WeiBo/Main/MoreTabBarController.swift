//
//  MoreTabBarController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class MoreTabBarController: UITabBarController {
    
    fileprivate lazy var publishBtn : UIButton = UIButton(imageName: "tabBar_publish_icon", bgImageName: "")
    fileprivate lazy var backBtn : TabBarButton = TabBarButton(normalImageName: "toolbar_leftarrow", highlightedImageName: "toolbar_leftarrow", title: "返回", titleColor: UIColor.gray, font: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.groupTableViewBackground
    
        
        tabBar.addSubview(publishBtn)
        publishBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        publishBtn.addTarget(self, action: #selector(publishBtnClick), for: .touchUpInside)
        
        
        tabBar.addSubview(backBtn)
        backBtn.center = CGPoint(x: tabBar.frame.size.width * 4.5 / 5.0 , y: tabBar.bounds.size.height * 0.5)
        
        backBtn.addTarget(self, action: #selector(backBtnBtnClick), for: .touchUpInside)
    }
    
    
    @objc fileprivate func publishBtnClick(){
        
        let publishVC = PublishViewController()
        
        window_ = UIWindow()
        window_.frame = moreWindow.frame
        window_.windowLevel = UIWindowLevelNormal
        window_.backgroundColor = UIColor.clear
        window_.alpha = 0.0
        window_.isHidden = false
        window_.rootViewController = publishVC
        
        UIView.animate(withDuration: 0.5, animations: {
            window_.alpha = 1.0
        }) { (finish) in
        }

    }
    
     @objc fileprivate func backBtnBtnClick(){
        UIView.animate(withDuration: 0.3, animations: {
             moreWindow.frame.origin.x = SCREENWITH
             UIApplication.shared.keyWindow?.frame.origin.x = 0
            }) { (finish) in
                moreWindow.isHidden = true
        }
    }

}
