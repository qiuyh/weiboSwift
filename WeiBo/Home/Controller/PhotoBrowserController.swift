//
//  PhotoBrowserController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/31.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

fileprivate let identifier = "PhotoBrowserCell"

class PhotoBrowserController: UIViewController {
    
    fileprivate lazy var layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    fileprivate var photosCollectionView:UICollectionView?
    fileprivate var indexPath       : IndexPath
    fileprivate var picUrls         : [URL]
    fileprivate var fromRectArray   : [CGRect]
    fileprivate var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.setStatusBarHidden(true, with: .none)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
    
    
    init(indexPath : IndexPath, picUrls : [URL], fromRectArray : [CGRect]) {
        
        self.indexPath     = indexPath
        self.picUrls       = picUrls
        self.fromRectArray = fromRectArray
        
        super.init(nibName: nil, bundle: nil)
        
        transitioningDelegate = self;
        modalPresentationStyle = .custom;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    fileprivate func setupUI(){
        
        photosCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        photosCollectionView?.frame.size.width += 20
        photosCollectionView?.backgroundColor = UIColor.clear
        photosCollectionView?.delegate = self
        photosCollectionView?.dataSource = self
        photosCollectionView?.showsVerticalScrollIndicator = false
        photosCollectionView?.showsHorizontalScrollIndicator = false
        photosCollectionView?.isPagingEnabled = true
        
        photosCollectionView?.register(PhotosCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        
        layout.itemSize = (photosCollectionView?.frame.size)!
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        view.addSubview(photosCollectionView!)
        
        photosCollectionView?.scrollToItem(at: self.indexPath, at: .left, animated: false)
    }

}


extension PhotoBrowserController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotosCell
        
        cell.display(picUrl: picUrls[indexPath.row])
        cell.dismissBlock { () in
            self.dismiss(animated: true, completion: nil)
    
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: HiddenPhotoNoti), object: indexPath)
        }
        
        self.indexPath = indexPath
        self.imageView.image = cell.lagerImageView.image
        
        return cell
    }
    
}

extension PhotoBrowserController:UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dismiss(animated: true, completion: nil)
    }


}

//MARk: - UIViewControllerTransitioningDelegate

extension PhotoBrowserController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PhotosAnimatedTransition(type: .PhotosAnimatedTransitionPresent, fromRect : fromRectArray[indexPath.row], toRect : getToRect(picUrl:  picUrls[indexPath.row]), imageView : imageView)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PhotosAnimatedTransition(type: .PhotosAnimatedTransitionDismiss, fromRect : fromRectArray[indexPath.row], toRect :  getToRect(picUrl:  picUrls[indexPath.row]), imageView : imageView)
    }
    
    
    fileprivate func getToRect(picUrl : URL) -> CGRect{
        
        let urlString = picUrl.absoluteString
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlString)
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
      
        guard let image1 = image else {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        let imageSize = image1.size
        
        let x : CGFloat = 0
        var y : CGFloat = 0
        let w : CGFloat = SCREENWITH
        let h : CGFloat = (imageSize.height * 2 * w) / (imageSize.width * 2)
        
        if h  > SCREENHEIGHT {
            y = 0
        }else{
            y = (SCREENHEIGHT - h) * 0.5
        }
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
}




