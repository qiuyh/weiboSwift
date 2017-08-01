//
//  ButtonICollectionView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class ButtonICollectionView: UICollectionView {
    
    fileprivate let identifier = "ButtonCell"
    
    var dataArray : [Square] = [Square](){
        didSet{
            reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        delegate   = self
        dataSource = self
    
//        register(ButtonCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        register(UINib.init(nibName: "ButtonCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        
        backgroundColor = UIColor.white
//        isScrollEnabled = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ButtonICollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ButtonCell
        
        let squareModel = dataArray[indexPath.row]
        
        
        let url = URL(string:squareModel.icon!)
        
        cell.imgView.sd_setImage(with: url, placeholderImage: UIImage(named:"mine_icon_nearby"))
        
        cell.titleLabel.text = squareModel.name
        
        return cell
        
    }
                 
    
}




