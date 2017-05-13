//
//  NetWorkInterfaceDemo.swift
//  SwiftCollection
//
//  Created by KeSen on 7/29/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator

class NetWorkInterfaceDemo: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: 使用 NSURLSession 进行请求
    func systemRequest() {
        let url = URL(string: "http://www.baidu.com")
        var request = URLRequest(url: url!)
        
        // 设置全局缓存
        let memoryCapacity = 4 * 1024 * 1024
        let diskCapacity = 10 * 1024 * 1024
        let cacheFilePath = "MyCache" // 相对于 /Library/Caches/[Boundle ID]/
        URLCache.shared = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: cacheFilePath)
        
        // 设置缓存策略
        request.cachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                print(response?.url ?? "nil")
            }
        }
        dataTask.resume()
    }
    
    func clearCacheFile() {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let bundleIdentifier = Bundle.main.bundleIdentifier
        // 拼接路径
        let projectCachePath = URL(fileURLWithPath: cachePath).appendingPathComponent(bundleIdentifier!)
        if let cacheFileList = try? FileManager.default.contentsOfDirectory(atPath: projectCachePath.path) {
            for fileName in cacheFileList {
                let willRemovedFilePath = projectCachePath.appendingPathComponent(fileName)
                
                if FileManager.default.fileExists(atPath: willRemovedFilePath.path) {
                    try? FileManager.default.removeItem(atPath: willRemovedFilePath.path)
                }
                
            }
        }
    
    }
    
    // MARK: 使用 Almofire 进行请求
    func almofireRequest() {
        let url = "http://mapi.tv.funshion.com/v2/index/"
        
        let clientVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
        let parameter: Parameters = [ "clientId": "2"
            , "uc" : "iphone"
            , "cl": "11"
            , "ve": clientVersion!]
        
        NetworkActivityIndicatorManager.shared.startDelay = 0.2
        
        Alamofire.request(url, method: .get, parameters: parameter).responseJSON { (response) in
            
            NetworkActivityIndicatorManager.shared.completionDelay = 0.2
            
            // original URL request
            print("request:", response.request ?? "nil", separator: "\n", terminator: "\n\n")
            
            // URL response
            print("response:", response.response ?? "nil", separator: "\n", terminator: "\n\n\n\n")
            
            // server data
            print("data:", response.data ?? "nil", separator: "\n", terminator: "\n\n\n\n")
            
            print(response.result)
            // result of response serialization
            print("result:", response.result, separator: "\n", terminator: "\n\n\n\n")
            
            switch response.result {
            case .success:
                if let JSON = response.result.value {
                    print("result.value:")
                    print("JSON: \(JSON)")
                    
                }
            case .failure(let error):
                print(error)
            }
        }

    }
}


