//
//  ButttonClickViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/10.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class ButttonClickViewController: UIViewController {
    
    fileprivate lazy var rightButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        title = "发微博"
        
        addBarButtonItem()
        addTextView()
        
        rightButton.isEnabled = false
        rightButton.backgroundColor = UIColor.white
    }
    
    
    fileprivate func addBarButtonItem(){
        let leftButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = leftButtonItem
        
        rightButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        rightButton.layer.cornerRadius = 5
        rightButton.clipsToBounds = true
        rightButton.setTitle("发送", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.setTitleColor(UIColor.lightGray, for: .disabled)
        rightButton.isEnabled = false
        rightButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        
        
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightButtonItem
        
        navigationController?.navigationBar.tintColor = UIColor.black;
    }
    
    fileprivate func addTextView(){
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: 200))
        textView.delegate = self
        view.addSubview(textView)
        
        textView.becomeFirstResponder()
    }
    
    
    @objc fileprivate func cancel(){
        self.dismiss(animated: true)
    }
    
     @objc fileprivate func send(){
        
    }

}

extension ButttonClickViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        
        print("textViewDidChange - \(textView.text)")
        if textView.text != nil && textView.text != "" {
            rightButton.isEnabled = true
            rightButton.backgroundColor = UIColor.orange
        }else{
            rightButton.isEnabled = false
            rightButton.backgroundColor = UIColor.white
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}


