//
//  LoginController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/17.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    fileprivate lazy var webView : UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithHexString(hexString: "#EEEEEE")
        title = "登录"
        let leftBarBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(canel))
        navigationItem.leftBarButtonItem = leftBarBtn
        
        let rightBarBtn = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navigationItem.rightBarButtonItem = rightBarBtn
        
        loadWebView()
        loadPage()
    }
    
    
    @objc fileprivate func canel(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarNav = storyboard.instantiateViewController(withIdentifier: "MainTabBarControllerNav")
        UIApplication.shared.keyWindow?.rootViewController = tabbarNav
    }
    
    @objc fileprivate func register(){
        let registertVC = RegisterController()
        let Nav = UINavigationController(rootViewController: registertVC)
        
        present(Nav, animated: true, completion: nil)
    }
    
    fileprivate func loadWebView(){
        webView.frame = view.frame
        webView.scrollView.alwaysBounceVertical = true
        webView.delegate = self
        
        view.addSubview(webView)
    }
    
    fileprivate func loadPage() {
        
        guard let url = URL(string: loginUrlString) else {
            return
        }

        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }

}

extension LoginController:UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        
        let urlString = url.absoluteString
        
        guard urlString.contains("code=") else {
            return true
        }
        
        let code = urlString.components(separatedBy: "code=").last!
        
        getAccessToken(code: code)
//        print("\(request.url?.absoluteString)")
        return false
    }
}


//MARK: - 获取数据
extension LoginController{
    
    fileprivate func getAccessToken(code:String){
        
        NetworkTool.shareInstance.getAccessToken(code: code) {[weak self] (result, error) in
            
            if error != nil{
                SVProgressHUD.showError(withStatus: "获取accessToken数据错误")
                print(error)
                return
            }
            
            guard let resultDic:Dictionary = result as! [String:Any]? else{
                SVProgressHUD.showError(withStatus: "没有获取accessToken的数据")
                return
            }
            
            
            print(resultDic)

            let user = UserInfo.shareInstance
            user.access_token  = resultDic["access_token"] as? String
            user.expires_in    = resultDic["expires_in"] as? String
            user.remind_in     = resultDic["remind_in"] as? String
            user.uid           = resultDic["uid"] as? String
    
            self?.getUserShow()
        }
    }
    
    
    fileprivate func getUserShow(){
        
        let user = UserInfo.shareInstance
        
        guard let access_token = user.access_token else {
            return
        }
        
        guard let uid = user.uid else {
            return
        }
        
        print(access_token,uid)
        
        NetworkTool.shareInstance.getUserShow(access_token, uid: "\(uid)") { (result, error) in
            
            if error != nil{
                SVProgressHUD.showError(withStatus: "获取用户数据错误")
                print(error)
                return
            }
            
            guard let resultDic:Dictionary = result as! [String:Any]? else{
                SVProgressHUD.showError(withStatus: "没有获取用户的数据")
                return
            }
            
            user.isLogin = true
            user.descrip      = resultDic["description"] as? String
            user.screen_name  = resultDic["screen_name"] as? String
            user.avatar_large = resultDic["avatar_large"] as? String
            user.followers_count = resultDic["followers_count"] as? intmax_t
            user.friends_count   = resultDic["friends_count"] as? intmax_t
            user.statuses_count  = resultDic["statuses_count"] as? intmax_t
            
            NSKeyedArchiver.archiveRootObject(user, toFile: user.userPath!)
            
            print(resultDic)
           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbarNav = storyboard.instantiateViewController(withIdentifier: "MainTabBarControllerNav")
            UIApplication.shared.keyWindow?.rootViewController = tabbarNav
            
        }
        
    }
}








