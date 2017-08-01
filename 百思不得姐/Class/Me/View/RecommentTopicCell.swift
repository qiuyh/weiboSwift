//
//  RecommentTopicCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/11/10.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class RecommentTopicCell: UITableViewCell {
    @IBOutlet weak var seletedIndicator: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seletedIndicator.isHidden = true
        titleLabel.highlightedTextColor = UIColor.red
        titleLabel.textColor = UIColor.gray
        selectionStyle  = .none
        backgroundColor = UIColor.groupTableViewBackground
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {

//        print(selected)
        seletedIndicator.isHidden = !selected
        if selected {
            titleLabel.textColor = UIColor.red
            backgroundColor = UIColor.white
        }else{
            titleLabel.textColor = UIColor.gray
            backgroundColor = UIColor.groupTableViewBackground
        }
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showData(topic : Topic){
        titleLabel.text = topic.name
    }
    
}
