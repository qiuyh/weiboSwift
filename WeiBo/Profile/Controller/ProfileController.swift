//
//  ProfileController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

fileprivate let height = (SCREENHEIGHT-108)/2.0-44

class ProfileController: UITableViewController {

    fileprivate lazy var loginHeadView : LoginProfileView = LoginProfileView(frame: CGRect(x: 0, y: 10, width: SCREENWITH, height: 150))
    fileprivate lazy var buttomView : RegisterAndLoginView = RegisterAndLoginView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: height+44))
    fileprivate lazy var headView : UIImageView = UIImageView(frame: CGRect(x: 0, y: -height, width: SCREENWITH, height: height))
    fileprivate lazy var avatarView : UIImageView = UIImageView(frame: CGRect(x: SCREENWITH/2.0 - 35, y: -120, width: 70, height: 70))
    fileprivate  var dataArray : Array = Array<Any>()
    fileprivate  var detailArray : Array = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        setupData()
        if UserInfo.shareInstance.isLogin! {
            getUserShow()
        }
    }
}

//MARK: - Action
extension ProfileController {
    
    fileprivate func getUserShow(){
        
        let user = UserInfo.shareInstance
        
//        print("getUserShow")
        
        guard let access_token = user.access_token else {
            return
        }
        
        guard let uid = user.uid else {
            return
        }
        
//        print(access_token,uid)
        
        NetworkTool.shareInstance.getUserShow(access_token, uid: "\(uid)") {[weak self] (result, error) in
            
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
            
            self?.setupData()
        }
    }
    
    fileprivate func setupData(){
    
        if UserInfo.shareInstance.isLogin! {
            
            dataArray = [["新的好友","新手任务"],["我的相册","我的赞"],["微博钱包","微博运动"],["草稿箱"],["更多"]]
            detailArray = [["                                                     ",
                            "完成任务，抽取大奖                                       "],
                           ["                                                     ",
                            "                                                     "],
                           ["魅蓝之夜科技狂欢                                        ",
                            "每天10000步，你达到了吗？                                "],
                           ["                                                     "],
                           ["点评、收藏                                             "]]
            
            tableView.sectionHeaderHeight = 5
            tableView.sectionFooterHeight = 5
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: 0.00001))
            
            let hView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: 170))
            hView.backgroundColor = UIColor.groupTableViewBackground
            hView.addSubview(loginHeadView)
            
            tableView.tableHeaderView = hView
            
        }else{

            dataArray = [["关注"]]
            detailArray = [["快看看大家都在关注谁                                     "]]
            addImageView()
            tableView.tableFooterView = buttomView
            tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: 0.00001))
            
            tableView.sectionHeaderHeight = 0.00001
            tableView.sectionFooterHeight = 0.00001
            
            
            buttomView.setLoginBlock { () -> (Void) in
                
                let loginVC = LoginController()
                let Nav = UINavigationController(rootViewController: loginVC)
                UIApplication.shared.keyWindow?.rootViewController = Nav
//                self.present(Nav, animated: true, completion: nil)
                
            }
            
            buttomView.setRigisterBlock { () -> (Void) in
                
                let registertVC = RegisterController()
                let Nav = UINavigationController(rootViewController: registertVC)
                
                self.present(Nav, animated: true, completion: nil)
                
            }

        }
        
        tableView.reloadData()
    
    }
    
    
    fileprivate func addImageView(){
        
        headView.image = UIImage(named: "profile_cover_background")
        headView.clipsToBounds = true
        headView.contentMode = .center
        tableView.insertSubview(headView, at: 0)
        tableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0)
        
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = avatarView.frame.size.width/2.0
        avatarView.image = UIImage(named: "sign-up_avatar_default")
        tableView.addSubview(avatarView)

    }
    
    
    
    @IBAction func setup(_ sender: UIBarButtonItem) {
        
        let setVC = SetupController(style: .grouped)
        setVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(setVC, animated: true)
        
    }
    
}


// MARK: - Table view data source
extension ProfileController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let array = dataArray[section]
        
        return UserInfo.shareInstance.isLogin! ? (array as AnyObject).count : dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ProfileCellID";
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: identifier)
        }
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.detailTextLabel?.textAlignment = .left
        cell?.accessoryType = .disclosureIndicator
        
        let  titleArray = dataArray[indexPath.section] as! [String]
        let  detailTitleArray = detailArray[indexPath.section] as! [String]
        
        cell?.textLabel?.text = titleArray[indexPath.row]
        cell?.detailTextLabel?.text = detailTitleArray[indexPath.row]
//        cell?.imageView?.image = UIImage(named: "login_more")
        
        return cell!
    }
    
}


// MARK: - Table view delage

extension ProfileController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Scroller view delage

extension ProfileController{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let point:CGPoint = scrollView.contentOffset;
//        print("\(point.y),,,\(height)")
        if (-height*2.0 < point.y && point.y < -height*0.5) {
            headView.frame.origin.y = point.y+64
            headView.frame.size.height = -point.y-64
        }

    }
}




