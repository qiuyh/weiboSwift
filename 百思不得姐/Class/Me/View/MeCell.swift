//
//  MeCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/9.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {

    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var allCountLabel: UILabel!
    @IBOutlet weak var subscribeCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subscribeBtn.layer.cornerRadius = 5
        subscribeBtn.clipsToBounds = true
        subscribeBtn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        subscribeBtn.layer.borderWidth = 0.5
        
        
        avarImageView.layer.cornerRadius = 5
        avarImageView.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model: SubscribeModel){
        
        avarImageView.sd_setImage(with: URL(string: model.image_list!), placeholderImage: UIImage(named: "setup-head-default"))
        titleLabel.text = model.theme_name
    
        subscribeCountLabel.text = model.sub_number
        if Int(model.sub_number!)! / 10000 >= 1 {
            subscribeCountLabel.text = String(format: "%.1f", Float(model.sub_number!)! / 10000.0)
        }
        
        allCountLabel.text = String(arc4random()%100 + 10000)
        
    }
    
    
    @IBAction func subscribeClick(_ sender: AnyObject) {
    }
    
}
