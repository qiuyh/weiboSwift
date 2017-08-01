//
//  StatusViewModel.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/25.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

let itemWith = (SCREENWITH-40)/3.0+3

class StatusViewModel: NSObject,NSCoding{
    
    //MARK: 微博对应的微博//statuses
    var mid        : String = "0"                 // 微博的ID
    var created_at : String?                     // 微博创建时间
    var source     : String?                    // 微博来源
    var text       : String?                   // 微博的正文
    var reposts_count   : Int = 0             // 转发数
    var comments_count  : Int = 0            // 评论数
    var attitudes_count : Int = 0           // 表态数
    
    
    //MARK: 微博对应的微博//user
    var profile_image_url : URL?            // 用户的头像
    var screen_name       : String?        // 用户的昵称
    var verified_image    : UIImage?      // 用户的认证类型
    var mbrank_image      : UIImage?     // 用户的会员等级
    
    
    //MARK: 微博对应的转发的微博//retweeted_status
    var retweeted_screen_name : String?
    var retweeted_text : String?
    
     //MARK: 微博对应的正图 或者 转发的微博的配图
    var pic_urls : [URL] = [URL]() // 微博的配图

     //MARK: cell的高度
    var cellHeight   : CGFloat = 60.0
    
    var textHeight   : CGFloat = 0.0
    
    var retextHeight : CGFloat = 0.0
    
    var picHeight    : CGFloat = 0.0
    
    //MARK: cell图片的大小
    var itemSize : CGSize = CGSize(width: itemWith, height: itemWith)

    init(statusModel:StatusModel) {
        super.init()
        
         /*************************微博的ID******************************/
        mid = statusModel.mid
        
        
         /**************************微博创建时间*****************************/
        if let time = statusModel.created_at {
//            created_at = NSDate.createDateBySring(string:time)
            created_at = time
        }
        
        
        /***************************微博来源****************************/
        if let modelSource = statusModel.source , modelSource  != "" {
            let startRange = modelSource.range(of: ">")
            source = modelSource.substring(from: (startRange?.upperBound)!)
            let endRange   = source?.range(of: "</")
            source = source?.substring(to: (endRange?.lowerBound)!)
            source = "来自" + source!
        }
        
        
         /***************************微博的正文****************************/
        if let modelText = statusModel.text {
            text = modelText
        }

        /***************************转发数、评论数、表态数****************************/
        reposts_count   = statusModel.reposts_count
        comments_count  = statusModel.comments_count
        attitudes_count = statusModel.attitudes_count
        
        
         /****************************用户的头像***************************/
        
        if let profileUrlString = statusModel.profile_image_url {
            profile_image_url = NSURL(string: profileUrlString) as URL?
        }
        
        
         /**************************用户的昵称*****************************/
        if let modelScreen_name = statusModel.screen_name{
            screen_name = modelScreen_name
        }
        
        
         /***************************用户的认证类型****************************/
        switch statusModel.verified_type {
        case 0:
            verified_image = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verified_image = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verified_image = UIImage(named: "avatar_grassroot")
        default:
            verified_image = nil
        }
        
        
         /*****************************用户的会员等级**************************/
        if statusModel.mbrank > 0 && statusModel.mbrank <= 6 {
            mbrank_image = UIImage(named: "common_icon_membership_level\(statusModel.mbrank)")
        }else{
            mbrank_image = nil
        }
        
        
         /*****************************转发用户的昵称**************************/
        if let modelRetweeted_screen_name = statusModel.retweeted_screen_name {
            retweeted_screen_name = modelRetweeted_screen_name
        }
        
        
         /*************************微博的转发正文******************************/
        if let modelRetweeted_text = statusModel.retweeted_text {
            retweeted_text = modelRetweeted_text
            
//            print(retweeted_screen_name,retweeted_text)
            retweeted_text = "@" + "\(retweeted_screen_name ?? ""): " + retweeted_text!
        }
        
        
         /****************************微博的配图***************************/
        let picUrls = statusModel.pic_urls?.count != 0 ? statusModel.pic_urls :statusModel.retweeted_pic_urls
        
        if let modelPic_urls  = picUrls{
            for picUrlDic in modelPic_urls {
                guard let picUrlString = picUrlDic["thumbnail_pic"] else {
                    continue
                }
                pic_urls.append(URL(string: picUrlString)!)
                
            }
        }
        
    }
    
    func getHeight(){
        /****************************正文高度***************************/
        let textLabel = MLEmojiLabel(frame: CGRect.zero)
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.customEmojiRegex = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
        textLabel.customEmojiPlistName = "expressionImage_custom"
        textLabel.text = text
        textHeight = textLabel.preferredSize(withMaxWidth: SCREENWITH - 20).height
        
        /****************************转发正文高度***************************/
        var retextH : CGFloat = 0
        if retweeted_text != nil{
            let retextLabel = MLEmojiLabel(frame: CGRect.zero)
            retextLabel.numberOfLines = 0
            retextLabel.font = UIFont.systemFont(ofSize: 14)
            retextLabel.customEmojiRegex = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
            retextLabel.customEmojiPlistName = "expressionImage_custom"
            retextLabel.text = retweeted_text
            retextHeight = retextLabel.preferredSize(withMaxWidth: SCREENWITH - 20).height
            retextH = retextHeight + 10
        }
        
        
        /****************************微博的配图所占高度***************************/
        var picH : CGFloat = 0
        if pic_urls.count != 0 {
            let vcount = ((pic_urls.count)-1)/3
            let with   = pic_urls.count == 1 ?  oneItemSize().height:itemWith
            
            let space  = (CGFloat)(vcount*5)
            picHeight  = with*CGFloat(vcount+1)+space
            picH = picHeight + 10
            
            /****************************微博的配图中的一张图的高度***************************/
            itemSize = pic_urls.count == 1 ?  oneItemSize(): CGSize(width: itemWith, height: itemWith)
        }else{
            retextH += 10
        }
        
        cellHeight = cellHeight + textHeight + retextH + picH + 30 + 44
    }
    
    
    fileprivate func oneItemSize() -> CGSize{
        
        let urlString = pic_urls.last?.absoluteString
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlString)
        
        guard let image1 = image else {
            return CGSize(width: 0.00001, height: 0.00001)
        }

        var imageSize = image1.size
        imageSize.width  = imageSize.width * 2 < itemWith ? itemWith:imageSize.width * 2
        imageSize.width  = imageSize.width  > (SCREENWITH - 20) ? (SCREENWITH - 20):imageSize.width
        imageSize.height = imageSize.width * imageSize.height / image1.size.width
        imageSize.height = imageSize.height > 2.5 * itemWith ? 2.5 * itemWith : imageSize.height
        
        return imageSize
    }
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        mid                   = aDecoder.decodeObject(forKey: "mid") as! String
        created_at            = aDecoder.decodeObject(forKey: "created_at") as! String?
        source                = aDecoder.decodeObject(forKey: "source") as! String?
        text                  = aDecoder.decodeObject(forKey: "text") as! String?
        profile_image_url     = aDecoder.decodeObject(forKey: "profile_image_url") as! URL?
        screen_name           = aDecoder.decodeObject(forKey: "screen_name") as! String?
        verified_image        = aDecoder.decodeObject(forKey: "verified_image") as! UIImage?
        mbrank_image          = aDecoder.decodeObject(forKey: "mbrank_image") as! UIImage?
        retweeted_screen_name = aDecoder.decodeObject(forKey: "retweeted_screen_name") as! String?
        retweeted_text        = aDecoder.decodeObject(forKey: "retweeted_text") as! String?
        pic_urls              = aDecoder.decodeObject(forKey: "pic_urls") as! [URL]
        cellHeight            = aDecoder.decodeObject(forKey: "cellHeight") as! CGFloat
        textHeight            = aDecoder.decodeObject(forKey: "textHeight") as! CGFloat
        retextHeight          = aDecoder.decodeObject(forKey: "retextHeight") as! CGFloat
        picHeight             = aDecoder.decodeObject(forKey: "picHeight") as! CGFloat
        itemSize              = aDecoder.decodeCGSize(forKey: "itemSize")
        reposts_count         = Int(aDecoder.decodeCInt(forKey: "reposts_count"))
        comments_count        = Int(aDecoder.decodeCInt(forKey: "comments_count"))
        attitudes_count       = Int(aDecoder.decodeCInt(forKey: "attitudes_count"))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mid, forKey: "mid")
        aCoder.encode(created_at, forKey: "created_at")
        aCoder.encode(source, forKey: "source")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(profile_image_url, forKey: "profile_image_url")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(verified_image, forKey: "verified_image")
        aCoder.encode(mbrank_image, forKey: "mbrank_image")
        aCoder.encode(retweeted_screen_name, forKey: "retweeted_screen_name")
        aCoder.encode(retweeted_text, forKey: "retweeted_text")
        aCoder.encode(pic_urls, forKey: "pic_urls")
        aCoder.encode(cellHeight, forKey: "cellHeight")
        aCoder.encode(textHeight, forKey: "textHeight")
        aCoder.encode(retextHeight, forKey: "retextHeight")
        aCoder.encode(picHeight, forKey: "picHeight")
        aCoder.encode(itemSize, forKey: "itemSize")
        aCoder.encode(reposts_count, forKey: "reposts_count")
        aCoder.encode(comments_count, forKey: "comments_count")
        aCoder.encode(attitudes_count, forKey: "attitudes_count")
    }


}


