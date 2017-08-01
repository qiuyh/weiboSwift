//
//  UrlString.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/17.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import Foundation

let loginUrlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
/* 
 POST/GET
 client_id	    true	string	申请应用时分配的AppKey。
 redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
 */


let	getAccessTokenString = "https://api.weibo.com/oauth2/access_token"
/*
 POST
 client_id	    true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	    true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 code	        true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */

let getUserShowString = "https://api.weibo.com/2/users/show.json"
/*
 GET
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 uid	        true	int64	需要查询的用户ID。
 */

let cacelAccessTokenString = "https://api.weibo.com/oauth2/revokeoauth2"
/*
 GET/POST
 access_token: 用户授权应用的access_token
 */


let getHome_timelineString = "https://api.weibo.com/2/statuses/home_timeline.json"
/*
 GET
 ccess_token  true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 since_id	  false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id	      false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 count	      false	int	单页返回的记录条数，最大不超过100，默认为20。
 page	      false	int	返回结果的页码，默认为1。
 base_app	  false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 feature	  false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 trim_user	  false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 */


/*********************************百思不得姐***************************************/


let getMeOpenString = "http://api.budejie.com/api/api_open.php"



		
