//
//  PresentationC.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/21.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class PresentationC: UIPresentationController {
    
    fileprivate lazy var coverView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        containerView?.insertSubview(coverView, at: 0)
        
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismisstap))
        coverView.addGestureRecognizer(tapGes)
    }
    
    @objc fileprivate func dismisstap(){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
