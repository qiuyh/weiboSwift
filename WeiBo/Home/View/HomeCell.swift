//
//  HomeCell.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/25.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

//let itemWith = (SCREENWITH-40)/3.0+3

class HomeCell: UITableViewCell {
    
    lazy var avatarImageView = UIImageView()
    lazy var enterpriseImageView = UIImageView()
    lazy var vipImageView = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var timeLabel = UILabel()
    lazy var originalLabel = UILabel()
    lazy var contentLabel  = MLEmojiLabel(frame: CGRect.zero)
    lazy var reContentLabel  = MLEmojiLabel(frame: CGRect.zero)
    lazy var reBgView  = UIView()
    lazy var layout = UICollectionViewFlowLayout()
    var pickView : PickCollectionView?
    lazy var toolView : ToolView = ToolView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: 44))
    
    var statusViewModel : StatusViewModel?{
        
        didSet{
            guard let statusViewModel = statusViewModel else {
                return
            }
            
            avatarImageView.sd_setImage(with: statusViewModel.profile_image_url, placeholderImage: UIImage(named: "avatar_default_small"))
            enterpriseImageView.image = statusViewModel.verified_image
            vipImageView.image        = statusViewModel.mbrank_image
            nameLabel.textColor       = (statusViewModel.mbrank_image != nil) ? UIColor.orange : UIColor.black
            nameLabel.text            = statusViewModel.screen_name
            timeLabel.text            = NSDate.createDateBySring(string:statusViewModel.created_at!)
            originalLabel.text        = statusViewModel.source
            contentLabel.text         = statusViewModel.text
            reContentLabel.text       = statusViewModel.retweeted_text
            pickView?.picURLs         = statusViewModel.pic_urls
            
            toolView.retweetedButton.setTitle("\(statusViewModel.reposts_count)", for: .normal)
            toolView.commentButton.setTitle("\(statusViewModel.comments_count)", for: .normal)
            toolView.supportButton.setTitle("\(statusViewModel.attitudes_count)", for: .normal)
            
            
            reBgView.isHidden = statusViewModel.retweeted_text == nil ? true:false

            layout.itemSize = statusViewModel.itemSize
            updatePickViewFrame(statusViewModel: statusViewModel)
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubView()
        addContraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    
    @objc fileprivate func clickNameLabel(tap:UITapGestureRecognizer){
        print(tap.view)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: -添加子视图
extension HomeCell{
    /****************************添加子视图*****************************************/
    fileprivate func addSubView(){
        
        avatarImageView.layer.cornerRadius = 22.5
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        let avatarTap = UITapGestureRecognizer(target: self, action: #selector(clickNameLabel))
        avatarImageView.addGestureRecognizer(avatarTap)
        
        enterpriseImageView.image = UIImage(named: "avatar_enterprise_vip")
        enterpriseImageView.sizeToFit()
        
        vipImageView.image = UIImage(named: "common_icon_membership_level1")
        vipImageView.sizeToFit()
        
        nameLabel.sizeToFit()
        nameLabel.isUserInteractionEnabled = true
        
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(clickNameLabel))
        nameLabel.addGestureRecognizer(nameTap)
        
        timeLabel.textColor = UIColor.lightGray
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.sizeToFit()
        
        originalLabel.textColor = UIColor.lightGray
        originalLabel.font = UIFont.systemFont(ofSize: 12)
        originalLabel.sizeToFit()
        
        contentLabel.numberOfLines = 0
        contentLabel.delegate = self
        contentLabel.isNeedAtAndPoundSign = true
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.customEmojiRegex = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
        contentLabel.customEmojiPlistName = "expressionImage_custom"
        contentLabel.sizeToFit()
        
        reBgView.backgroundColor = UIColor.groupTableViewBackground
        reBgView.isHidden = true
        
        reContentLabel.numberOfLines = 0
        reContentLabel.delegate = self
        reContentLabel.isNeedAtAndPoundSign = true
        reContentLabel.font = UIFont.systemFont(ofSize: 14)
        reContentLabel.customEmojiRegex = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
        reContentLabel.customEmojiPlistName = "expressionImage_custom"
        reContentLabel.sizeToFit()
        
        layout.itemSize = CGSize(width:itemWith, height: itemWith)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        pickView = PickCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(enterpriseImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(vipImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(originalLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(reBgView)
        contentView.addSubview(reContentLabel)
        contentView.addSubview(pickView!)
        contentView.addSubview(toolView)
        
    }
}

//MARK: -添加约束
extension HomeCell{

    /****************************添加约束*****************************************/
    fileprivate func addContraint(){
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(5)
            make.top.equalTo(contentView).offset(5)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        enterpriseImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatarImageView).offset(0)
            make.right.equalTo(avatarImageView).offset(0)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(contentView).offset(10)
        }
        
        vipImageView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.top.equalTo(contentView).offset(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        originalLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(5)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(60)
            make.right.equalTo(contentView).offset(-10)

        }
        
        reContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.right.equalTo(contentView).offset(-10)
        }
        
        reBgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(reContentLabel.snp.top).offset(-10)
            make.right.equalToSuperview()
            make.bottom.equalTo((pickView?.snp.bottom)!).offset(10)
        }
        
        pickView?.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(reContentLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(-10)
            make.size.equalTo(CGSize(width: SCREENWITH - 20, height: SCREENWITH - 20))
        }
        
        toolView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREENWITH, height: 44))
        }
    }
    
    /****************************改变pickView的Frame*****************************************/
    fileprivate func updatePickViewFrame(statusViewModel : StatusViewModel){
        
        pickView?.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREENWITH - 20, height: statusViewModel.picHeight))
        }
 
        if pickView?.picURLs.count == 0 {
            pickView?.snp.updateConstraints({ (make) in
                make.top.equalTo(reContentLabel.snp.bottom).offset(5)
            })

        }else{
            pickView?.snp.updateConstraints({ (make) in
                make.top.equalTo(reContentLabel.snp.bottom).offset(reContentLabel.text == nil ? -5:5)
            })
        }
        
        layoutIfNeeded()
    }
}


//MARK: -MLEmojiLabelDelegate

extension HomeCell : MLEmojiLabelDelegate{
    func mlEmojiLabel(_ emojiLabel: MLEmojiLabel!, didSelectLink link: String!, with type: MLEmojiLabelLinkType) {
        
        switch type {
        case MLEmojiLabelLinkType.email: break
        case MLEmojiLabelLinkType.phoneNumber: break
        case MLEmojiLabelLinkType.at: break
        case MLEmojiLabelLinkType.poundSign: break
        default:break//url
        }
        
        print(type)
    }
}



