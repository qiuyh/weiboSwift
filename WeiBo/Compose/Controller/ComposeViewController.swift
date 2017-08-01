//
//  ComposeViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    //MARK:- 懒加载
    fileprivate lazy var cancelTabBarView : CancelTabarView = CancelTabarView(frame:  CGRect(x: 0, y:SCREENHEIGHT - 49 , width: SCREENWITH, height: 49))
    fileprivate lazy var composeBtnView :ComposeView = ComposeView(frame: CGRect(x: 0, y: SCREENHEIGHT/2.5-50, width: SCREENWITH, height: SCREENHEIGHT*0.6+10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(colorLiteralRed: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 0.8)
        // Do any additional setup after loading the view.
        
        //MARK:-添加底部取消按钮View
        cancelTabBarView.isShowArrow = false
        //MARK:- 点击返回按钮
        cancelTabBarView.cancelCallBackBlock { [weak self]() -> (Void) in
            self?.composeBtnView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
        view.addSubview(cancelTabBarView)
        
        
        
        //MARK:-闭包监听左右滑动事件
        composeBtnView.callBackBlock { [weak self](isShow) in
            self?.cancelTabBarView.isShowArrow =  isShow ? true:false
        }
        
        //MARK:-闭包监听present事件
        composeBtnView.presentVCBlock {[weak self] () -> (Void) in
            
            if !(self?.cancelTabBarView.isShowArrow!)! {
                UIView.animate(withDuration: 0.1, animations: {
                    self?.cancelTabBarView.transformFrome()
                    
                    }, completion: { (finish) in
                        window_.isHidden = true
                        window_.rootViewController = nil
                        
                        let btnClickVC = ButttonClickViewController()
                        let nav = UINavigationController(rootViewController: btnClickVC)
                        UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
                })
                
            }
            
        }
        
        view.addSubview(composeBtnView)
        
        
        setupTapGesture()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //旋转恢复原型
        UIView.animate(withDuration: 0.5) {
            self.cancelTabBarView.transformTo()
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.composeBtnView.showAnimateBtn()
        }
    }
    
    deinit {
//        print("ComposeViewController-deinit");
    }
    
}

//MARK:- 摧毁控制器-dismiss

extension ComposeViewController{
    
    fileprivate func setupTapGesture(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
}

extension ComposeViewController{
    @objc internal func dismissVC(){
        
        //旋转成➕字
        if !cancelTabBarView.isShowArrow! {
            UIView.animate(withDuration: 0.1) {
                self.cancelTabBarView.transformFrome()
            }
        }
        
        composeBtnView.hideAnimateBtn()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()  + 0.25) {
            
//            window_.windowLevel = UIWindowLevelNormal
            window_.isHidden = true
            window_.rootViewController = nil
            
//            UIApplication.shared.keyWindow?.rootViewController = composeVC
            
//            self.dismiss(animated: true, completion: nil)
        }
    }
}


//MARK:- UIGestureRecognizerDelegate方法
extension ComposeViewController:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view?.isKind(of:UIButton().classForCoder))!{
            return false
        }
        
        return true
    }
}










