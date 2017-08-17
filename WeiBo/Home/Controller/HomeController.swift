//
//  HomeController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/13.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    fileprivate lazy var logoutView : HomeLogoutView = HomeLogoutView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: SCREENHEIGHT))
    fileprivate lazy var titleBtn : NavTitleView = NavTitleView()

    fileprivate lazy var headView : HeadView = HeadView()
    
    fileprivate lazy var dataArray : [StatusViewModel] = [StatusViewModel]()
    
    fileprivate lazy var tipLabel : UILabel = UILabel()
    
    fileprivate var dataPath : String?
    
    override func loadView() {

        UserInfo.shareInstance.isLogin! ? super.loadView():loadLogoutView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserInfo.shareInstance.isLogin! {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
            
            setupTitleView()
            addHeadView()
            addTipLabel()
            addOldData()
            addMj_refresh()
            
            NotificationCenter.default.addObserver(self, selector: #selector(clickLagerImage), name: NSNotification.Name(rawValue: ClickPhotoToLagerNoti), object: nil)
        }
        
        
//        // 2.根据id拼接info.plist的路径
//        let plistPath = Bundle.main.path(forResource: "default.plist", ofType: nil)!
//        
//        // 3.根据plist文件的路径读取数据 [[String : String]]
//        let array = NSArray(contentsOfFile: plistPath)! as! [[String : String]]
//        
//        let plistPat = Bundle.main.path(forResource: "lxh.plist", ofType: nil)!
//        
//        // 3.根据plist文件的路径读取数据 [[String : String]]
//        let arra = NSArray(contentsOfFile: plistPat)! as! [[String : String]]
//        
//        var arr = [[String:String]]()
//        
//        arr = array + arra
//        
//        
//        var rootArray = [String:String]()
//        // 4.遍历数组
//        for dict in arr {
//            if let chs = dict["chs"] ,let png = dict["png"] {
//                
//                rootArray[chs] = png
//            }
//        }
//        
//        
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//        let documentsDirectory = paths.object(at: 0) as! NSString
//        let path = documentsDirectory.appendingPathComponent("expressionImage_custom.plist")
//        
//        
////        let filePatch = Bundle.main.bundlePath + "/expression_custom.plist";
////         let result = fm.createFile(atPath: filePatch, contents: nil, attributes: nil)
//        
//
//        let  dic = NSDictionary(dictionary: rootArray)
//        let result = dic.write(toFile: path, atomically: true)
//        
//        print("result==\(result)",path)
//
    }

}

extension HomeController{
    
    fileprivate func setupTitleView(){
        
        titleBtn.setTitle(UserInfo.shareInstance.screen_name!, for: .normal)
        titleBtn.addTarget(self, action: #selector(clickTitleView), for: .touchUpInside)
        
        navigationItem.titleView = titleBtn
    }
    
    fileprivate func addHeadView(){
        
        tableView.tableHeaderView = headView
        tableView.separatorStyle  = .none
        headView.title = "大家正在搜：97路"
        headView.present { () in
            let searchVC = SearchViewController()
            searchVC.modalTransitionStyle = .crossDissolve
            searchVC.searchTitle = self.headView.title
            let nav = UINavigationController(rootViewController: searchVC)
            nav.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
        
        tableView.tableFooterView = UIView()
        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    

    fileprivate func addTipLabel(){
        tipLabel.frame = CGRect(x: 0, y: 10, width: SCREENWITH, height: 34)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
    }
}

//MARK: - Action
extension HomeController {
    
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

    
    fileprivate func loadLogoutView(){
        view = logoutView
        //去关注
        logoutView.setAttentionCallBlock { () -> (Void) in
            print("HomeController-setAttentionCallBlock")
        }
    }
    
    
    /**
     点击titleView
     */
    @objc fileprivate func clickTitleView(){
        
        titleBtn.isSelected = !titleBtn.isSelected
        titleBtn.bgView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.titleBtn.bgView.isHidden = true
        }
        
        let popVC = PopViewController()
        popVC.delage = self
        popVC.defualTitle = titleBtn.currentTitle
        present(popVC, animated: true, completion: nil)
 
    }
    
    /**
     点击查看大图
     */
    @objc fileprivate func clickLagerImage(noti : Notification){
        
        let userInfo      = noti.userInfo
        let indexPath     = userInfo?["indexPath"] as! IndexPath
        let picUrls       = userInfo?["picUrls"] as! [URL]
        let fromRectArray = userInfo?["fromRectArray"] as! [CGRect]
        
        let photosVC = PhotoBrowserController(indexPath: indexPath, picUrls: picUrls, fromRectArray : fromRectArray)
        
        present(photosVC, animated: true, completion: nil)
    }
}

//MARK: - 从本地获取\存数据
extension HomeController {
     fileprivate func addOldData(){
        
        let homePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        dataPath = (homePath as NSString).appendingPathComponent("homeData.plist")
        
        let arr = NSKeyedUnarchiver.unarchiveObject(withFile: dataPath!)
        if arr != nil {
            dataArray = arr as! Array
            tableView.reloadData()
        }
    }
    
    fileprivate func writeRootObject(data:[StatusViewModel]){
        NSKeyedArchiver.archiveRootObject(data, toFile: dataPath!)
    }
}


//MARK: - refresh
extension HomeController {
    
    fileprivate func addMj_refresh(){
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
//        tableView.mj_header.beginRefreshing()
    }
}

//MARK: - Action
extension HomeController {
    
    @objc fileprivate func loadNewData(){
        getNewInformation(loadNew: true)
    }
    
    @objc fileprivate func loadMoreData(){
        getNewInformation(loadNew: false)
    }
    
    fileprivate func getNewInformation(loadNew:Bool){
        
        var since_id = "0"
        var max_id   = "0"
        
        if loadNew {
            since_id = dataArray.first?.mid ?? "0"
        } else {
            max_id = dataArray.last?.mid ?? "0"
            max_id = max_id == "0" ? "0" : "\((Int(max_id)! - 1))"
        }
        print(since_id,max_id)
        SVProgressHUD.show()
        NetworkTool.shareInstance.getHomeInformation(since_id, max_id: max_id) { [weak self](result, error) in
//            print(result,error)
            
            if error != nil {
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "获取数据失败！")
                print(error)
                self?.tableView.mj_footer.endRefreshing()
                self?.tableView.mj_header.endRefreshing()
                return
            }
            
            guard let dic = result as? [String:Any] else{
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "获取数据失败！")
                self?.tableView.mj_footer.endRefreshing()
                self?.tableView.mj_header.endRefreshing()
                return
            }
            
            let resultArray = dic["statuses"] as! [[String:Any]]
//            print(resultArray)
            var tempViewModel = [StatusViewModel]()
            for statusDic in resultArray{
                let status = StatusModel(dict: statusDic as [String : AnyObject])
                let statusViewModel = StatusViewModel(statusModel: status)
                
                var dicM = [String : Any]()
                dicM["source"] = statusViewModel.source
                dicM["topicContent"] = statusViewModel.text
                dicM["commentsCount"] = statusViewModel.attitudes_count
                dicM["plNum"] = statusViewModel.comments_count
                dicM["currentTimeType"] = statusViewModel.created_at
                dicM["userHeadPicUrl"] = statusViewModel.profile_image_url
                dicM["userNick"] = statusViewModel.screen_name
                
                var i:Int = 0
                var picArrM = [[String : Any]]()
                for url in statusViewModel.pic_urls{
                    var picDicM = [String : Any]()
                    i += 1
                    let urlString = url.absoluteString
                    picDicM["pictureThumpath"] = urlString
                    let lagerImageUrl = urlString.replacingOccurrences(of: "thumbnail", with: "bmiddle")
                    picDicM["picturePath"] = lagerImageUrl
                    picDicM["sortNum"] = i
                    
                    picArrM.append(picDicM)
                }
                    
                dicM["topicPictureList"] = picArrM
                
                print(dicM)
                
                tempViewModel.append(statusViewModel)
            }

            
            if loadNew {
                self?.dataArray = tempViewModel + (self?.dataArray)!
            }else{
                self?.dataArray += tempViewModel
            }
            
            self?.downloadImage(viewModelArray: tempViewModel,loadNew:loadNew)
            
        }
    }
    
    fileprivate func downloadImage(viewModelArray:[StatusViewModel], loadNew:Bool){
        
        let group = DispatchGroup()
        
        for viewModel in viewModelArray {
            for url in viewModel.pic_urls {
                group.enter()
                SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (_, _, _, _, _, _) in
                     group.leave()
                })
            }
        }
        
        
        group.notify(queue: DispatchQueue.main) {
            
            for viewModel in viewModelArray {
                viewModel.getHeight()
            }
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
            self.writeRootObject(data: (self.dataArray))
            
            if viewModelArray.count != 0{
                
                if loadNew{
                    self.showTipLabel(count: viewModelArray.count)
                }
            }
        }
        
    }
    
    
    fileprivate func showTipLabel(count:Int){
        
        tipLabel.isHidden = false
        tipLabel.text = "更新了\(count) 条微博"

        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.tipLabel.frame.origin.y = 44
            }, completion: { (_) -> Void in
                UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: { () -> Void in
                    self.tipLabel.frame.origin.y = 10
                    }, completion: { (_) -> Void in
                        self.tipLabel.isHidden = true
                })
        })
    }
}


//MARK: - PopViewControllerDelage
extension HomeController:PopViewControllerDelage{
    func dismissAction() {
        titleBtn.isSelected = !titleBtn.isSelected
    }
    
    func didSelectRow(title:String){
        titleBtn.setTitle(title, for: .normal)
    }
}


// MARK: - Table view data source
extension HomeController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return dataArray.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "HomeCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if cell == nil {
            cell = HomeCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        
        (cell as! HomeCell).statusViewModel = dataArray[indexPath.row] as StatusViewModel
     
     return cell!
     }
}

// MARK: - Table view delage
extension HomeController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (dataArray[indexPath.row] as StatusViewModel).cellHeight
    }
}
