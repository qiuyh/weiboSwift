//
//  PickImageCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/27.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class PickImageCell: UICollectionViewCell {
    lazy var iconImageView : UIImageView = UIImageView()
    lazy var gifImageView  : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func layoutView(){
//        iconImageView.frame = contentView.frame
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        iconImageView.isUserInteractionEnabled = true
        contentView.addSubview(iconImageView)
        
        gifImageView.image = UIImage(named: "timeline_image_gif")
        gifImageView.isHidden = true
        iconImageView.addSubview(gifImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        gifImageView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 25))
        }
    }
    
    public func setData(picURL : URL){
        
        if picURL.absoluteString.hasSuffix(".gif"){
            gifImageView.isHidden = false
        }else{
            gifImageView.isHidden = true
        }
        
        iconImageView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "empty_picture"), options: []) { (image, _, _, _) in
            
//            if (image != nil) {
//                if self.frame.size.width != itemWith || self.frame.size.height != itemWith {
//                    UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0.0)
//                    let with   = self.frame.size.width
//                    let height = with * (image?.size.height)! / (image?.size.width)!
//                    
//                    image?.draw(in: CGRect(x: 0, y: 0, width: with, height: height))
//                    
//                    self.iconImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//                    
//                    UIGraphicsEndImageContext()
//                }
//            }
        }
        
    }
    
}



