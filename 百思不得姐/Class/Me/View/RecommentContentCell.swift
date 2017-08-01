//
//  RecommentContentCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/10.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class RecommentContentCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var attentionLabel: UILabel!
    
    @IBOutlet weak var attentionBtn: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = 20
        iconImageView.clipsToBounds = true
      
        attentionBtn.layer.cornerRadius = 5
        attentionBtn.clipsToBounds = true
        attentionBtn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        attentionBtn.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(content : Content){
        
//        print(content.header!,content.fans_count)
        iconImageView.sd_setImage(with: URL(string: content.header!), placeholderImage: UIImage(named: "setup-head-default"))
        titleLabel.text = content.screen_name
        
        if let count = content.fans_count {
            attentionLabel.text = String(count).appending("人关注")
        }
    }
    
    
    
    @IBAction func attentionAction(_ sender: AnyObject) {
        
    }
    
    
}
