//
//  NetworkTool.swift
//  WeiBo
//
//  Created by iMacQIU on 16/10/17.
//  Copyright © 2016年 iMacQIU. All rights reserved.
//

import UIKit

class NetworkTool: AFHTTPSessionManager {

    
    static let shareInstance :NetworkTool = {
        let netTool = NetworkTool()
        netTool.responseSerializer.acceptableContentTypes?.insert("text/html")
        netTool.responseSerializer.acceptableContentTypes?.insert("text/plain")

        return netTool
    }()

}

extension NetworkTool{
//POST
    func postNetworking(urlString: String,parameters: [String : AnyObject],completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        post(urlString, parameters: parameters, progress: nil, success: { (task, result) in
            completion(result,nil)
        }) { (task, error) in
            completion(nil,error)
        }
    }
//GET
    func getNetworking(urlString: String,parameters: [String : AnyObject],completion: @escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        get(urlString, parameters: parameters, progress: nil, success: { (task, result) in
            completion(result,nil)
        }) { (task, error) in
            completion(nil,error)
        }
    }
}

//MARK: - 取消AccessToken授权

extension NetworkTool{
    func cancelAccessToken(completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["access_token" : UserInfo.shareInstance.access_token!]
        
        print(parameters)
        postNetworking(urlString: cacelAccessTokenString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }
}


//MARK: - 获取AccessToken

extension NetworkTool{
    func getAccessToken(code:String,completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
       let parameters = ["client_id"     : app_key,
                         "client_secret" : app_secret,
                         "grant_type"    : "authorization_code",
                         "redirect_uri"  : redirect_uri,
                         "code"          : code
                        ]
        
        postNetworking(urlString: getAccessTokenString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }
}


//MARK: - 获取用户信息

extension NetworkTool{
    func getUserShow(_ access_token : String, uid : String, completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        getNetworking(urlString: getUserShowString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }
}


//MARK: - 获取首页的微博信息

extension NetworkTool{
    func getHomeInformation(_ since_id : String, max_id : String, completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["access_token" : UserInfo.shareInstance.access_token!, "since_id" : since_id, "max_id" : max_id]
        
        getNetworking(urlString: getHome_timelineString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }
}


/*********************************百思不得姐***************************************/

//MARK: - 获取我的界面信息

extension NetworkTool{
    
    func getMeOpen(completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["a" : "square", "c" : "topic"]
        
        getNetworking(urlString: getMeOpenString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }

    
    func getSubscribe(completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["a" : "tags_list", "c" : "subscribe"]
        
        getNetworking(urlString: getMeOpenString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }
    
    
    func getTopic(completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["a" : "category", "c" : "subscribe"]
        
        getNetworking(urlString: getMeOpenString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }
    
    func getContent(category_id : Int,page : Int,completion:@escaping (_ success: Any?,_ failure: Error?) -> ()){
        
        let parameters = ["a" : "list", "c" : "subscribe", "category_id" : String(category_id), "page" : String(page)]
        
        getNetworking(urlString: getMeOpenString, parameters: parameters as [String : AnyObject]) { (result, error) in
            
            completion(result,error)
        }
    }

}



