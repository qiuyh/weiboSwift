//
//  RecommendViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/10.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {
    
    fileprivate let topicIdentifier = "RecommentTopicCell"
    fileprivate let contentIdentifier = "RecommentContentCell"
    fileprivate var dataArray    : [Topic]   = [Topic]()
    fileprivate var contentArray : [Content] = [Content]()
    fileprivate var seletedTopicModel : Topic = Topic()
    @IBOutlet weak var topicTableView: UITableView!
    @IBOutlet weak var contentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "推荐关注"

        topicTableView.backgroundColor   = UIColor.groupTableViewBackground
        contentTableView.backgroundColor = UIColor.groupTableViewBackground
        contentTableView.rowHeight = 60;
        topicTableView.register(UINib.init(nibName: topicIdentifier, bundle: nil), forCellReuseIdentifier: topicIdentifier)
        contentTableView.register(UINib.init(nibName: contentIdentifier, bundle: nil), forCellReuseIdentifier: contentIdentifier)
        
        addMj_refresh()
        
        if ShareModel.shareModel.topicArray.count > 0 {
            dataArray = ShareModel.shareModel.topicArray
            topicTableView.reloadData()
            topicTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
            
            contentArray = (dataArray.first?.list)!
            seletedTopicModel = (dataArray.first)!
            contentTableView.reloadData()
            
        }else{
            getTopicData()
        }
    }
    
    
    fileprivate func getTopicData(){
        
        SVProgressHUD.show()
        NetworkTool.shareInstance.getTopic {[weak self] (reuslt, error) in
            
            SVProgressHUD.dismiss()
            
            if error == nil{
                
                guard let listArray = (reuslt as! [String : Any])["list"] else{
                    return
                }
                
//                print(listArray)
                for topic in listArray as! [[String : Any]]{
                    let topicModel = Topic()
                    topicModel.setValuesForKeys(topic)
                    topicModel.ID = topic["id"] as! Int?
                    self?.dataArray.append(topicModel)
                }
                
                ShareModel.shareModel.topicArray = (self?.dataArray)!
                self?.topicTableView.reloadData()
                self?.topicTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
                self?.seletedTopicModel = (self?.dataArray.first)!
                self?.contentTableView.mj_header.beginRefreshing()
                
            }else{
                print(error)
            }
        }
    }
    
    fileprivate func getTContentData(){
        guard let id = seletedTopicModel.ID else {
            return
        }
       
         NetworkTool.shareInstance.getContent(category_id:id, page:seletedTopicModel.next_page) {[weak self] (reuslt, error) in
        
            self?.contentTableView.mj_footer.endRefreshing()
            self?.contentTableView.mj_header.endRefreshing()

            if error == nil{
                guard let listArray = (reuslt as! [String : Any])["list"] else{
                    return
                }
//                 print(reuslt)
                if self?.seletedTopicModel.next_page == 1 {
                    self?.seletedTopicModel.list.removeAll()
                }
                for content in listArray as! [[String : Any]]{
                    let contentModel = Content()
                    contentModel.setValuesForKeys(content)
                    contentModel.fans_count = content["fans_count"] as! Int?

                    self?.seletedTopicModel.list.append(contentModel)
                }
                
                self?.contentArray = (self?.seletedTopicModel.list)!
                
                guard let total_page = (reuslt as! [String : Any])["total_page"] else{
                    return
                }
                guard let next_page = (reuslt as! [String : Any])["next_page"] else{
                    return
                }
                
                self?.seletedTopicModel.total_page = total_page as! Int
                self?.seletedTopicModel.next_page  = next_page  as! Int
            
                self?.contentTableView.reloadData()
                
                
            }else{
                print(error)
            }
        }
    }
    
    @objc fileprivate func loadNewData(){
        seletedTopicModel.next_page  = 1
        seletedTopicModel.total_page = 1
        
        getTContentData()
    }

    @objc fileprivate func loadMoreData(){
        if seletedTopicModel.next_page > seletedTopicModel.total_page {
            return
        }
        
        getTContentData()
    }
    
    fileprivate func addMj_refresh(){
        contentTableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        contentTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        contentTableView.mj_footer.isHidden = true
    }
    
    fileprivate func hideRefresh(){
        if contentTableView.mj_footer.isRefreshing() {
            contentTableView.mj_footer.endRefreshing()
        }
        
        if contentTableView.mj_header.isRefreshing() {
            contentTableView.mj_header.endRefreshing()
        }
   
        contentTableView.mj_footer.resetNoMoreData()
        
        if seletedTopicModel.next_page > seletedTopicModel.total_page {
            contentTableView.mj_footer.endRefreshingWithNoMoreData()
            contentTableView.mj_footer.isHidden = true
        }else{
            if contentArray.count > 0 {
                contentTableView.mj_footer.isHidden = false
            }else{
                contentTableView.mj_footer.endRefreshingWithNoMoreData()
                contentTableView.mj_footer.isHidden = true
            }
        }
    }
}


//MARK: -UITableViewDataSource

extension RecommendViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.isEqual(topicTableView) {
        return dataArray.count
        }
        if contentArray.count > 0 {
            hideRefresh()
        }
        
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView.isEqual(topicTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: topicIdentifier) as! RecommentTopicCell
            cell.showData(topic: dataArray[indexPath.row])
            return cell
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: contentIdentifier) as! RecommentContentCell
        cell.showData(content : contentArray[indexPath.row])
        return cell
        
    }
}


//MARK: -UITableViewDelegate

extension RecommendViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEqual(topicTableView) {
            let topic = dataArray[indexPath.row]
            contentArray = topic.list
            seletedTopicModel = topic
//            print(topic.next_page,topic.total_page)
            hideRefresh()
            contentTableView.reloadData()
            
            contentTableView.setContentOffset(CGPoint(x: 0, y: seletedTopicModel.contentOffsetY), animated: false)
            
            print(topic.next_page)
            if topic.next_page == 1 {
                contentTableView.mj_header.beginRefreshing()
            }
            
        }else{
            
           tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
}


//MARK: -UITableViewDelegate

extension RecommendViewController{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        seletedTopicModel.contentOffsetY = scrollView.contentOffset.y
//        print(scrollView.contentOffset.y)
    }
    
}



