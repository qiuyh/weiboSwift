//
//  PopViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/19.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

protocol PopViewControllerDelage:NSObjectProtocol {
    
    func dismissAction();
    
    func didSelectRow(title:String);
}

class PopViewController: UIViewController {
    
    var delage:PopViewControllerDelage?
    
    var defualTitle : String?
    
    fileprivate lazy var popTableView : UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    fileprivate lazy var footViewBtn : UIButton = UIButton(type: .system)
    fileprivate lazy var dataArray : Array = [["首页","好友圈","群微博"],["特别关心","同学","海大","同事","悄悄关注"],["周边微博"]]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        transitioningDelegate = self;
        modalPresentationStyle = .custom;
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        loadBgImageView()
        loadTableView()
        loadFootView()
        
        var row = 0
        var section = 0
        
        for i in 0..<dataArray.count {
            for j in 0..<dataArray[i].count {
                if defualTitle == dataArray[i][j] {
                    section = i
                    row = j
                    break
                }
            }
        }
        
         popTableView.selectRow(at:  NSIndexPath(row: row, section: section) as IndexPath, animated: false, scrollPosition: .none)
        
    }
    
}

extension PopViewController{
    
    fileprivate func loadBgImageView(){
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "popover_background")
//        bgImageView.alpha = 0.9
        view.addSubview(bgImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    fileprivate func loadTableView(){
        
        popTableView.delegate = self
        popTableView.dataSource = self
        popTableView.backgroundColor = UIColor.clear
        popTableView.separatorStyle = .none
        view.addSubview(popTableView)
        
        popTableView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(20)
            make.bottom.equalTo(view).offset(-45)
        }
        
    }
    
    fileprivate func loadFootView(){
        footViewBtn.setTitle("编辑我的分组", for: .normal)
        footViewBtn.setTitleColor(UIColor.white, for: .normal)
        footViewBtn.layer.cornerRadius = 5
        footViewBtn.clipsToBounds = true
        footViewBtn.layer.borderColor = UIColor.black.cgColor
        footViewBtn.layer.borderWidth = 0.3
        
        footViewBtn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        view.addSubview(footViewBtn)
        
        footViewBtn.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(35)
            make.bottom.equalTo(view).offset(-10)
        }
        
    }
    
    @objc fileprivate func clickBtn(){
        print("clickBtn")
    }
}

//MARK: - UITableViewDataSource
extension PopViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "PopViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil{
            cell = PopCell(style: .default, reuseIdentifier: identifier) 
        }
        
        cell?.textLabel?.text = dataArray[indexPath.section][indexPath.row]
      
        return cell!
    }
}

//MARK: - UITableViewDelegate
extension PopViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let headerView = UILabel()
            headerView.textColor = UIColor.black
            headerView.font = UIFont.systemFont(ofSize: 12)
            headerView.lineBreakMode = NSLineBreakMode.byWordWrapping
            headerView.text = section == 1 ?
                "——我的分组——————————————————————————————————————————————————————————":
                "——其他——————————————————————————————————————————————————————————————"
            headerView.sizeToFit()
            
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 18
        }
        
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = UIColor.orange
        
        if delage != nil {
            
            var title = (cell?.textLabel?.text)!
            
            if indexPath.row == 0 {
                title = UserInfo.shareInstance.screen_name!
            }
            
            delage?.didSelectRow(title: title)
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UIViewControllerTransitioningDelegate

extension PopViewController:UIViewControllerTransitioningDelegate{
    
    // 目的:改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = PresentationC(presentedViewController: presented, presenting: presenting)
        
        return presentation
    }

    // 目的:自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransition(type: .TransitionTypePresent)
    }
    
    // 目的:自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if delage != nil {
            delage?.dismissAction()
        }
        
        popTableView.removeFromSuperview()
        footViewBtn.removeFromSuperview()
        
        
        return AnimatedTransition(type: .TransitionTypeDismiss)
    }
}
