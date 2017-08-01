//
//  MainTabBarController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

var window_ : UIWindow = UIWindow()
var moreWindow : UIWindow = UIWindow()

class MainTabBarController: UITabBarController {
    
    fileprivate lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    fileprivate lazy var moreBtn : TabBarButton = TabBarButton(normalImageName: "tabbar_more", highlightedImageName: "tabbar_more_selected", title: "更多", titleColor: UIColor.gray, font: 10)

    override func viewDidLoad() {
        super.viewDidLoad()

       setupComposeButton()
    }

}
//MARK:- 设置UI界面

extension MainTabBarController{
    fileprivate func setupComposeButton(){

        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
        
        
        tabBar.addSubview(moreBtn)
        moreBtn.center = CGPoint(x: tabBar.frame.size.width * 4.5 / 5.0, y: tabBar.bounds.size.height * 0.5)
        
        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)

        let moreStoryBoard = UIStoryboard(name: "More", bundle: nil)
        let moreTabBarVC = moreStoryBoard.instantiateViewController(withIdentifier: "MoreTabBarController")
        
        moreWindow.frame = (UIApplication.shared.keyWindow?.frame)!
        moreWindow.windowLevel = UIWindowLevelNormal
        moreWindow.rootViewController = moreTabBarVC
      
    }
}

//MARK:- 监听事件

extension MainTabBarController{
    @objc fileprivate func composeBtnClick(){
        
        let composeVC = ComposeViewController()
        
        window_ = UIWindow()
        window_.frame = (UIApplication.shared.keyWindow?.frame)!
        window_.windowLevel = UIWindowLevelNormal
        window_.backgroundColor = UIColor.clear
        window_.alpha = 0.0
        window_.isHidden = false
        window_.rootViewController = composeVC
        
        UIView.animate(withDuration: 0.5, animations: {
            window_.alpha = 1.0
        }) { (finish) in
        }
        
    }
    
    
     @objc fileprivate func moreBtnClick(){
        moreWindow.isHidden = false
        moreWindow.frame.origin.x = SCREENWITH
        UIApplication.shared.keyWindow?.frame.origin.x = 0
        UIView.animate(withDuration: 0.3) {
            moreWindow.frame.origin.x = 0
            UIApplication.shared.keyWindow?.frame.origin.x = -SCREENWITH
        }
    }
}


