//
//  AnimatedTransition.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/20.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit


enum TransitionType:NSInteger{
    case TransitionTypePresent = 0
    case TransitionTypeDismiss = 1
}

class AnimatedTransition: NSObject {
    
    fileprivate var type :TransitionType?

    init(type:TransitionType) {
        self.type = type
    }
}

extension AnimatedTransition:UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch type! {
        case .TransitionTypePresent:
            presentAnimation(transitionContext: transitionContext)
        case .TransitionTypeDismiss:
            dismissAnimation(transitionContext: transitionContext)
        }
    }
}


extension AnimatedTransition{
    
    fileprivate func presentAnimation(transitionContext:UIViewControllerContextTransitioning){

        let toView   = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let containerView = transitionContext.containerView
        
        toView.frame = CGRect(x: SCREENWITH/2.0 - 100, y: 55, width: 200, height: 0)
        toView.alpha = 0.0
        
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.frame.size.height = 350
            toView.alpha = 1.0
            
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
    
    fileprivate func dismissAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.frame.size.height = 0
            fromView.alpha = 0.0
            
        }) { (finished) in
            transitionContext.completeTransition(true)
        }

    }
}



