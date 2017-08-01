//
//  TopicViewController.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/16.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let acr:CGFloat = CGFloat(arc4random()%255)
        let r = acr/CGFloat(255)
        let acb:CGFloat = CGFloat(arc4random()%255)
        let b = acb/CGFloat(255)
        let acg:CGFloat = CGFloat(arc4random()%255)
        let g = acg/CGFloat(255)
        
        view.backgroundColor = UIColor.init(colorLiteralRed:Float(r) , green: Float(g), blue: Float(b), alpha: 1.0)

    }

}
