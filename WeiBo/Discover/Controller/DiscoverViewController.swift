//
//  DiscoverViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/12.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class DiscoverViewController: UITableViewController {
    
    fileprivate lazy var headView : HeadView = HeadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if UserInfo.shareInstance.isLogin! == true {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
            
            addHeadView()
        }
    }
}

extension DiscoverViewController{
    
    fileprivate func addHeadView(){
        
        tableView.tableHeaderView = headView
        headView.title = "大家正在搜：大叔卖早点月收2万"
        headView.isCenter = true
        
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


//MARK: - Action
extension DiscoverViewController {
    
    @IBAction func login(_ sender: UIBarButtonItem) {
        
        let loginVC = LoginController()
        let Nav = UINavigationController(rootViewController: loginVC)
        
        UIApplication.shared.keyWindow?.rootViewController = Nav
//        present(Nav, animated: true, completion: nil)

    }
    
    
    @IBAction func register(_ sender: UIBarButtonItem) {
        
        let registertVC = RegisterController()
        let Nav = UINavigationController(rootViewController: registertVC)
        
        present(Nav, animated: true, completion: nil)

    }
    
    
}


// MARK: - Table view data source
extension DiscoverViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
}
