//
//  SearchViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/24.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    fileprivate lazy var navTitleView : SearchHeadView = SearchHeadView(frame: CGRect(x: 0, y: 0, width: SCREENWITH - 60, height: 30))
    fileprivate lazy var bgView : UIView  = UIView(frame: (UIApplication.shared.keyWindow?.bounds)!)
    var searchTitle:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithHexString(hexString: "#EEEEEE")
        
        let rightButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationController?.navigationBar.tintColor = UIColor.black;
        
        bgView.backgroundColor = UIColor.lightGray
        bgView.alpha = 0.6
        
        navigationItem.titleView = navTitleView

        if (searchTitle?.contains("大家正在搜："))! {
            searchTitle = searchTitle?.substring(from: "大家正在搜：".endIndex)
        }
        navTitleView.searchTextField.placeholder = searchTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.keyWindow?.addSubview(bgView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0.0
        }) { (finish) in
            self.bgView.removeFromSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navTitleView.searchTextField.resignFirstResponder()
        
        self.bgView.alpha = 0.6
        UIApplication.shared.keyWindow?.addSubview(bgView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0.0
        }) { (finish) in
            self.bgView.removeFromSuperview()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc fileprivate func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       navTitleView.searchTextField.resignFirstResponder()
    }

}





