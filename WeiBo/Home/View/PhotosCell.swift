//
//  PhotosCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/31.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    lazy var lagerImageView : UIImageView = UIImageView()
    fileprivate lazy var scrollview : UIScrollView = UIScrollView()
    fileprivate var dismissVcBlock : ((Void) -> (Void))?
    
    fileprivate let maxScale: CGFloat = 3.0 // 最大的缩放比例
    fileprivate let minScale: CGFloat = 1.0 // 最小的缩放比例
    
    fileprivate let animDuration: CGFloat = 0.5 // 动画时长
    fileprivate var imagewith: CGFloat = 320
    fileprivate var imageHeight: CGFloat = 568
    fileprivate var scale: CGFloat = 1.0 // 当前的缩放比例
    fileprivate var touchX: CGFloat = 0.0 // 双击点的X坐标
    fileprivate var touchY: CGFloat = 0.0 // 双击点的Y坐标
    fileprivate var isDoubleTapingForZoom: Bool = false // 是否是双击缩放
    
    fileprivate var isLoading: Bool = false//是否在加载
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         layoutView()
//        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func layoutView(){
        scrollview.frame = contentView.frame
        scrollview.frame.size.width -= 20
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.backgroundColor = UIColor.black
        scrollview.delegate = self
        scrollview.maximumZoomScale = maxScale // scrollView最大缩放比例
        scrollview.minimumZoomScale = minScale // scrollView最小缩放比例
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        scrollview.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapClick))
        doubleTap.numberOfTapsRequired = 2
        scrollview.addGestureRecognizer(doubleTap)
        singleTap.require(toFail: doubleTap)

        
        lagerImageView.contentMode = .scaleAspectFill
        lagerImageView.clipsToBounds = true
        lagerImageView.isUserInteractionEnabled = true
        lagerImageView.backgroundColor = UIColor.red
        
        contentView.addSubview(scrollview)
        scrollview.addSubview(lagerImageView)
        
    }

    
    func display(picUrl : URL){
        
        SVProgressHUD.dismiss()
        
        scale = minScale
        isDoubleTapingForZoom = false
        scrollview.setZoomScale(scale, animated: false)

        let urlString = picUrl.absoluteString
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlString)
        
        guard let image1 = image else {
            return
        }
        
        let lagerImageUrl = urlString.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        
//        print(lagerImageUrl)
        
        guard let url = URL(string: lagerImageUrl) else {
            return
        }
        
        isLoading = true
        lagerImageView.sd_setImage(with: url, placeholderImage: image1, options: [], progress: { (current, total, _) in
            
            if self.isLoading {
                let progress = CGFloat(current) / CGFloat(total)
                SVProgressHUD.showProgress(Float(progress))
                SVProgressHUD.setDefaultStyle(.dark)
            }
            
        }) { (image, error, _, _) in
            
            SVProgressHUD.dismiss()
            self.isLoading = false
            
            let imageSize = image?.size
            
            let x : CGFloat = 0
            var y : CGFloat = 0
            let w : CGFloat = self.scrollview.frame.size.width
            let h : CGFloat = (imageSize!.height * 2 * w) / (imageSize!.width * 2)
            
            if h  > self.scrollview.frame.size.height {
                y = 0
            }else{
                y = (self.scrollview.frame.size.height - h) * 0.5
            }
            
            self.imagewith   = w
            self.imageHeight = h
            
            self.lagerImageView.frame = CGRect(x: x, y: y, width: w, height: h)
            self.scrollview.contentSize = CGSize(width: 0, height: self.lagerImageView.frame.size.height)
        }
      
//        if lagerImageUrl.hasSuffix(".gif") {
////            print(url)
//            SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (image, data, error, cacheType, finished, imageURL) in
//                print(image,data,error,cacheType,finished,imageURL)
//                self.lagerImageView.image = UIImage.sd_animatedGIF(with: data as Data!)
//            })
//
//        }else{
//           
//        }
    }
    
    
    @objc fileprivate func dismissVC(){
        
        SVProgressHUD.dismiss()
        self.isLoading = false
        
        if dismissVcBlock != nil {
             dismissVcBlock!()
        }
    }
    
    
    func dismissBlock(block:@escaping (Void) -> ()){
        self.dismissVcBlock = block
    }
}

// MARK: - UIScrollViewDelegate
extension PhotosCell:UIScrollViewDelegate{
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {

        //当捏或移动时，需要对center重新定义以达到正确显示位置
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height / 2 : centerY
        
        lagerImageView.center = CGPoint(x: centerX, y: centerY)
        
        // ****************双击放大图片关键代码*******************
        if isDoubleTapingForZoom {
            let contentOffset = scrollview.contentOffset
            let center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5)
            let offsetX = center.x - self.touchX
            let offsetY = center.y - self.touchY
            
            let maxOffsetX = (imagewith - (SCREENWITH - imagewith) * 0.5) * (maxScale - 1)
            let maxOffsetY = (imageHeight - (SCREENHEIGHT - imageHeight) * 0.5) * (maxScale - 1)
            var x = contentOffset.x - offsetX * maxScale
            var y = contentOffset.y - offsetY * maxScale
           
            if x < 0 {
                x = 0
            }else if x > maxOffsetX {
                x = maxOffsetX
            }
            
            if y < 0 {
                y = 0
            }else if y > maxOffsetY {
                y = maxOffsetY
            }
            
            scrollview.contentOffset = CGPoint(x: x, y: y)
        }
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scale = scale
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return isLoading ? nil : lagerImageView
    }
    

    // 双击手势事件
    @objc func doubleTapClick(tap: UITapGestureRecognizer) {
        if isLoading {
            return
        }
        
        touchX = tap.location(in: tap.view).x
        touchY = tap.location(in: tap.view).y
        
        if scale > minScale {
            scale = minScale
            scrollview.setZoomScale(scale, animated: true)
        } else {
            scale = maxScale
            isDoubleTapingForZoom = true
            scrollview.setZoomScale(scale, animated: true)
        }
        isDoubleTapingForZoom = false
        
    }

}


