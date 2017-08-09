//
//  PickCollectionView.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/27.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class PickCollectionView: UICollectionView {

    var picURLs : [URL] = [URL]() {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate   = self
        dataSource = self
        
        let identifier = "pickCell"
        register(PickImageCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        
        backgroundColor = UIColor.clear
        isScrollEnabled = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc fileprivate func hiddenPhoto(noti : Notification){
        let indexPath = noti.object as! IndexPath
        
        let cell = cellForItem(at: indexPath) as! PickImageCell
        cell.iconImageView.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            cell.iconImageView.isHidden = false
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: HiddenPhotoNoti), object: nil)
    }

}


extension PickCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "pickCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PickImageCell
        
        cell.setData(picURL: picURLs[indexPath.row])
        
        return cell
    }
    
    
//    func collectionView(collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: NSIndexPath) -> CGSize{
//        
////        UICollectionViewFlowLayout
//        
//        return CGSize(width: itemWith, height: itemWith);
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var index = indexPath
        index.row = 0
        var fromRectArray = [CGRect]()
        
        for _ in picURLs {
            let cell = collectionView.cellForItem(at: index) as! PickImageCell
            let fromRect = convert(cell.frame, to: UIApplication.shared.keyWindow!)
            fromRectArray.append(fromRect)
            index.row += 1
        }
        
        let userInfo = ["indexPath" : indexPath, "picUrls" : picURLs, "fromRectArray" : fromRectArray] as [String : Any]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ClickPhotoToLagerNoti), object: nil, userInfo: userInfo)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenPhoto), name: NSNotification.Name(rawValue: HiddenPhotoNoti), object: nil)
    }
}






