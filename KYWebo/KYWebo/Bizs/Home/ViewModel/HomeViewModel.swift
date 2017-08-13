//
//  HomeViewModel.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import MBProgressHUD

typealias TimelineSuccess = ([HomeItemViewModel]) -> Void
typealias TimelineFailed  = (Error) -> Void

class HomeViewModel: NSObject {
    
    var timelineSuccess: TimelineSuccess?
    var timelineFailed: TimelineFailed?
    
    override init() {
        super.init()
        requestTimelineDats()
    }

    // 请求主页数据
    func requestTimelineDats() {
        guard let authData = UserDefaults.standard.object(forKey: "WeboAuthData") as? [String: Any] else {
            return
        }
        
        var params: [String: String] = [:]
        params["access_token"] = authData["AccessTokenKey"] as? String
        params["count"] = "5"
        
        _ = WBHttpRequest(url: "https://api.weibo.com/2/statuses/home_timeline.json",
                          httpMethod: "GET",
                          params: params,
                          delegate: self,
                          withTag: "homeTag")
    }
}

extension HomeViewModel: WBHttpRequestDelegate {
    
    func request(_ request: WBHttpRequest!, didFinishLoadingWithDataResult data: Data!) {
        if let json = String(data: data, encoding: .utf8) {
            print("json = \(String(describing: json))")
            
            if let item: WbTimeline = WbTimeline.model(withJSON: json) {
                if let successBlock = timelineSuccess {
                    
                    var dataSource: [HomeItemViewModel] = []
                    DispatchQueue.global().async(execute: { 
                        for statues in item.statuses {
                            let itemViewmodel = HomeItemViewModel(withStatus: statues)
                            dataSource.append(itemViewmodel)
                        }
                        successBlock(dataSource)
                    })
                }
            }
        }
    }
    
    func request(_ request: WBHttpRequest!, didFailWithError error: Error!) {
        if let failedBlock = timelineFailed {
            failedBlock(error)
        }
    }
}
