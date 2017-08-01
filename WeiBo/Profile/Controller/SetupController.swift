//
//  SetupController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/19.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class SetupController: UITableViewController {
    
    fileprivate let dataInArray:Array  = [["账号管理","账号安全"],["通知","隐私","通用设置"],["清理缓存","意见反馈","关于微博"]]
    fileprivate let dataOutArray:Array = [["通用设置"],["关于微博"]]
    fileprivate lazy var footBtn : UIButton = UIButton(type: .system)
    fileprivate lazy var footView:UIView = UIView()
    
    fileprivate var dataArray:[[String]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "设置"
        navigationController?.navigationBar.tintColor = UIColor.black;
        
        if UserInfo.shareInstance.isLogin! {
            setupFootView()
            
            dataArray = dataInArray
        }else{
            dataArray = dataOutArray
        }
        
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    fileprivate func setupFootView(){

        footView.backgroundColor = UIColor.groupTableViewBackground
        footView.frame = CGRect(x: 0, y: 0, width: SCREENWITH, height:80)
        
        footBtn.setTitle("退出当前账号", for: .normal)
        footBtn.setTitleColor(UIColor.red, for: .normal)
        footBtn.addTarget(self, action: #selector(clickFootView), for: .touchUpInside)
        footBtn.frame = CGRect(x: 0, y: 20, width: SCREENWITH, height: 44)
        footBtn.backgroundColor = UIColor.white
        
        
        tableView.tableFooterView = footView
        footView.addSubview(footBtn)
    }
    
    @objc fileprivate func clickFootView(){
        
        SVProgressHUD.show()
        NetworkTool.shareInstance.cancelAccessToken { (result, error) in
            print("result==\(result),error==\(error)")
            
            SVProgressHUD.dismiss()
            //&& (result as! Dictionary)["result"]! == true
            if error == nil {
                
                let user = UserInfo.shareInstance
                UserInfo.shareInstance.isLogin! = false
                NSKeyedArchiver.archiveRootObject(user, toFile: user.userPath!)
                
                let loginVC = LoginController()
                let Nav = UINavigationController(rootViewController: loginVC)
                UIApplication.shared.keyWindow?.rootViewController = Nav
            }else{
                SVProgressHUD.showError(withStatus: "退出账号失败！")
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return (dataArray[section] ).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "SetupControllerCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.accessoryType = .disclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.text = dataArray[indexPath.section][indexPath.row]
        

        return cell!
    }
    
     // MARK: - Table view delage
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
}





