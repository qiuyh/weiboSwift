//
//  PhotosAnimatedTransition.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/3.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

//protocol PhotosAnimatedTransitionDelegate {
//    func fromRect(indexPath : NSIndexPath) -> CGRect
//    func toRect(indexPath : NSIndexPath) -> CGRect
//}

enum PhotosAnimatedTransitionType:NSInteger {
    case PhotosAnimatedTransitionPresent = 0
    case PhotosAnimatedTransitionDismiss = 1
}

class PhotosAnimatedTransition: NSObject {
    
    fileprivate var type : PhotosAnimatedTransitionType = .PhotosAnimatedTransitionPresent
    fileprivate var fromRect  : CGRect
    fileprivate var toRect    : CGRect
    fileprivate var imageView : UIImageView
    
    init(type : PhotosAnimatedTransitionType, fromRect : CGRect, toRect : CGRect, imageView : UIImageView) {
        
        self.type      = type
        self.fromRect  = fromRect
        self.toRect    = toRect
        self.imageView = imageView
    }

}

extension PhotosAnimatedTransition:UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if type == .PhotosAnimatedTransitionPresent {
            presentAnimation(transitionContext: transitionContext)
        }else{
            dismissAnimation(transitionContext: transitionContext)
        }
    }
    
    
    
    fileprivate func presentAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        let toView   = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.black
        
        toView.alpha = 0.0
        
        imageView.frame = fromRect
        
        containerView.addSubview(toView)
        containerView.addSubview(imageView)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.2, options: [], animations: {
            self.imageView.frame = self.toRect
            
        }) { (finished) in
            toView.alpha = 1.0
            self.imageView.removeFromSuperview()
            containerView.backgroundColor = UIColor.clear
            transitionContext.completeTransition(true)
        }
        
    }
    
    
    fileprivate func dismissAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        fromView.removeFromSuperview()
        
        let containerView = transitionContext.containerView
        imageView.frame = toRect
        containerView.addSubview(imageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.imageView.frame = self.fromRect
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }
}










