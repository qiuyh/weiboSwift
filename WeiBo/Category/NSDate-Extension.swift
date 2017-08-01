//
//  NSDate-Extension.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/26.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import Foundation

extension  NSDate{
    
    class func createDateBySring(string : String) -> String{
        
        // 1.创建时间格式化对象
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en")
        
        // 2.将字符串时间,转成NSDate类型
        guard let createDate = formatter.date(from: string) else {
            return ""
        }
        // 3.创建当前时间
        let nowDate = Date()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 5.对时间间隔处理
        // 5.1.显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2.59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 5.3.11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 5.4.创建日历对象
        let calendar = Calendar.current
        
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            formatter.dateFormat = "昨天 HH:mm"
            let timeStr = formatter.string(from: createDate)
            return timeStr
        }
        
        // 5.6.处理一年之内: 02-22 12:22
        let cmps = (calendar as NSCalendar).components(.year, from: createDate, to: nowDate, options: [])
        if cmps.year! < 1 {
            formatter.dateFormat = "MM-dd HH:mm"
            let timeStr = formatter.string(from: createDate)
            return timeStr
        }
        
        // 5.7.超过一年: 2014-02-12 13:22
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = formatter.string(from: createDate)
        return timeStr
    }
    
}
