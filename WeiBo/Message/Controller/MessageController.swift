//
//  MessageController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class MessageController: UITableViewController {
    
    fileprivate lazy var logoutView : MessageLogoutView = MessageLogoutView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: SCREENHEIGHT))
    fileprivate lazy var buttomView : RegisterAndLoginView = RegisterAndLoginView(frame: CGRect(x: 0, y: SCREENHEIGHT/1.8, width: SCREENWITH, height: SCREENHEIGHT/2.0))
    fileprivate lazy var imageArray : Array = ["messagescenter_at","messagescenter_comments","messagescenter_good"]
    fileprivate lazy var titleArray : Array = ["@我的","评论","赞"]
    
    fileprivate lazy var headView : HeadView = HeadView()
    
    override func loadView() {
        UserInfo.shareInstance.isLogin! ? super.loadView():loadLogoutView()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserInfo.shareInstance.isLogin! {
             addHeadView()
        }
    
    }
}

//MARK: - Action
extension MessageController {

    
    fileprivate func loadLogoutView(){
        view = logoutView
        view.addSubview(buttomView)
        
        buttomView.setLoginBlock { () -> (Void) in
          
            let loginVC = LoginController()
            let Nav = UINavigationController(rootViewController: loginVC)
            UIApplication.shared.keyWindow?.rootViewController = Nav
//            self.present(Nav, animated: true, completion: nil)
            
        }
        
        buttomView.setRigisterBlock { () -> (Void) in
            
            let registertVC = RegisterController()
            let Nav = UINavigationController(rootViewController: registertVC)
            
            self.present(Nav, animated: true, completion: nil)

        }
    }

}

extension MessageController {
    
    fileprivate func addHeadView(){
        
        tableView.tableHeaderView = headView
        headView.present { () in
            let searchVC = SearchViewController()
            searchVC.modalTransitionStyle = .crossDissolve
            searchVC.searchTitle = self.headView.title
            let nav = UINavigationController(rootViewController: searchVC)
            nav.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
        
        tableView.tableFooterView = UIView()
    }
}


// MARK: - Table view data source
extension MessageController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "MessageCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        
        cell?.accessoryType = .disclosureIndicator
        
        
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        cell?.textLabel?.text = titleArray[indexPath.row]
        
        return cell!
    }
    
}

// MARK: - Table view delage
extension MessageController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


