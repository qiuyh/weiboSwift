//
//  RegisterController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/17.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    fileprivate lazy var webView : UIWebView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithHexString(hexString: "#EEEEEE")
        title = "注册"

        let leftBarBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(canel))
        navigationItem.leftBarButtonItem = leftBarBtn
    
        loadWebView()
    }
    
    @objc fileprivate func canel(){
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func loadWebView(){
        webView.frame = view.frame
        webView.scrollView.alwaysBounceVertical = true
        
        view.addSubview(webView)
    }
}
