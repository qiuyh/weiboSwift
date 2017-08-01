//
//  PopCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/31.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class PopCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.white
        textLabel?.highlightedTextColor = UIColor.orange
        selectionStyle  = .none
        backgroundColor = UIColor.clear
    }
    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        
//        if highlighted {
//           backgroundColor = UIColor.red
//        }else{
//            backgroundColor = UIColor.clear
//        }
//        
//        super.setHighlighted(highlighted, animated: animated)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        
        if selected {
        
            backgroundColor = UIColor.init(colorLiteralRed: 103.0/255, green: 103.0/255, blue: 103.0/255, alpha: 1.0)
            textLabel?.textColor = UIColor.orange
        }else{
            backgroundColor = UIColor.clear
            textLabel?.textColor = UIColor.white
        }
        

        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
