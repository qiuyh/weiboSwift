//
//  MeHeadView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class MeHeadView: UIView {

    var SquareArray : [Square] = [Square](){
        didSet{
            buttonView.dataArray = SquareArray
        }
    }
    fileprivate let itemWith12 = (SCREENWITH - 20) / 5.0 - 10
    fileprivate let itemHeight = SCREENWITH / 5.0 + 7
    fileprivate lazy var buttonView : ButtonICollectionView = ButtonICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loginRegisterView()
        navView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func loginRegisterView(){
        backgroundColor = UIColor.groupTableViewBackground
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 10, width: SCREENWITH, height: 44)
        button.setBackgroundImage(UIImage(named: "1"), for: .normal)
        button.setBackgroundImage(UIImage(named: "2"), for: .highlighted)
        
        let imageview = UIImageView()
        imageview.image = UIImage(named: "setup-head-default")
        imageview.backgroundColor = UIColor.clear
        imageview.sizeToFit()
        imageview.frame.origin.x = 20
        imageview.center.y = button.frame.size.height * 0.5
        
        let titleLabel = UILabel()
        titleLabel.text = "登录/注册"
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.sizeToFit()
        titleLabel.frame.origin.x = imageview.frame.maxX + 20
        titleLabel.center.y = imageview.center.y
        
        
        button.addSubview(imageview)
        button.addSubview(titleLabel)
        
        button.addTarget(self, action: #selector(loginRegisterAction), for: .touchUpInside)
        
        addSubview(button)
    }
    
     private func navView(){
        buttonView.frame = CGRect(x: 0, y: 64, width: SCREENWITH, height: 2 * itemHeight + 30)
        buttonView.contentInset = UIEdgeInsetsMake(5, 5, 10, 5)
        buttonView.showsVerticalScrollIndicator = false
        buttonView.showsHorizontalScrollIndicator = false
//        buttonView.isPagingEnabled = true
        
        let layout = buttonView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWith12, height: itemHeight)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
//        layout.headerReferenceSize = CGSize(width: 7.5, height: buttonView.frame.size.height)
//        layout.footerReferenceSize = CGSize(width: 7.5, height: buttonView.frame.size.height)
//        layout.minimumInteritemSpacing = 10
        
        addSubview(buttonView)
    }
    
    @objc private func loginRegisterAction(){
//        print("loginRegisterAction")
    }
}
