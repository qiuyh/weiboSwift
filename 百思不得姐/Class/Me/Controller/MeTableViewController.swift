//
//  MeTableViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/8.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

class MeTableViewController: UITableViewController {
    
    fileprivate lazy var subscribeArray : [SubscribeModel] = [SubscribeModel]()
    fileprivate lazy var headView : MeHeadView = MeHeadView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: 225))
    fileprivate let identifier = "MeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 251/255.0, green: 31/255.0, blue: 70/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.lightGray
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        setTableView()
        
        addBarButtonItems()
        
        getDataFromArchiver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if headView.SquareArray.count == 0 {
            getMeSquareData()
        }
        
        if subscribeArray.count == 0 {
            getSubscribeData()
        }
    }
    
}


// MARK: - setup
extension MeTableViewController{
    // MARK: 设置tableView
    fileprivate func setTableView(){
        view.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableHeaderView = headView
    }
    
    // MARK: 添加BarButtonItems
    fileprivate func addBarButtonItems(){
        let settingItem = UIBarButtonItem.init(customView: UIButton(normalImageName: "mine-setting-icon", highlightedImageName: "mine-setting-icon-click", targer: self, action: #selector(settingClick)))
        let moonItem = UIBarButtonItem.init(customView: UIButton(normalImageName: "mine-moon-icon", highlightedImageName: "mine-moon-icon-click", targer: self, action: #selector(settingClick)))
        navigationItem.rightBarButtonItems = [settingItem, moonItem];
        
        let letfItem = UIBarButtonItem.init(customView: UIButton(normalImageName: "friendsRecommentIcon", highlightedImageName: "friendsRecommentIcon-click", targer: self, action: #selector(friendsClick)))
        navigationItem.leftBarButtonItem = letfItem
    }
    
    
    fileprivate func getDataFromArchiver(){
        let pathFile1 = (documentPath as NSString).appendingPathComponent("squareArray.plist")
        let array1 = NSKeyedUnarchiver.unarchiveObject(withFile: pathFile1)
        if let arr1 = array1 {
             headView.SquareArray = arr1 as! [Square]
        }
        
        
        let pathFile2 = (documentPath as NSString).appendingPathComponent("subscribeArray.plist")
        let array2 = NSKeyedUnarchiver.unarchiveObject(withFile: pathFile2)
        if let arr2 = array2 {
            subscribeArray = arr2 as! [SubscribeModel]
        }
    
        tableView.reloadData()
    }
}

// MARK: - action
extension MeTableViewController{
    @objc func settingClick(){
        
    }
    
    @objc func moonClick(){
        
    }
    
    
    @objc func friendsClick(){
        let recommendVC = RecommendViewController(nibName: "RecommendViewController", bundle: nil)
        recommendVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recommendVC, animated: true)
    }

    
    // MARK: getMeSquareData
    fileprivate func getMeSquareData(){
        NetworkTool.shareInstance.getMeOpen {[weak self] (result, error) in
            if error == nil {
                
                guard let squareArray = (result as! [String : Any])["square_list"] else{
                    return
                }
                
                var urlArray = [String]()
                
                var array = [Square]()
                for square in squareArray as! [[String : Any]]{
                    
                    
                    if urlArray.contains(square["url"] as! String){
                        continue
                    }
                    urlArray.append(square["url"] as! String)
                    
                    
                    let squrtModel = Square()
                    squrtModel.setValuesForKeys(square)
                    
                    array.append(squrtModel)
                }
                
                let pathFile = (documentPath as NSString).appendingPathComponent("squareArray.plist")
                NSKeyedArchiver.archiveRootObject(array, toFile: pathFile)
                
                self?.headView.SquareArray = array
                self?.tableView.reloadData()
                
            }else{
                print(error)
            }
        }
    }
    
    // MARK: getSubscribeData
    fileprivate func getSubscribeData(){
        
        NetworkTool.shareInstance.getSubscribe {[weak self] (result, error) in
            if error == nil {
                
                guard let subscribeArray = (result as! [String : Any])["rec_tags"] else{
                    return
                }

                var arr = [SubscribeModel]()
                for subscribe in subscribeArray as! [[String : Any]]{
                    let subscribeModel = SubscribeModel()
                    subscribeModel.setValuesForKeys(subscribe)
                    
                    arr.append(subscribeModel)
                }
                
                let pathFile = (documentPath as NSString).appendingPathComponent("subscribeArray.plist")
                NSKeyedArchiver.archiveRootObject(arr, toFile: pathFile)

                self?.subscribeArray = arr
                self?.tableView.reloadData()
                
            }else{
                print(error)
            }
        }
    }
}

// MARK: - Table view data source
extension MeTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribeArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MeCell

        cell.setData(model: subscribeArray[indexPath.row])
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}




