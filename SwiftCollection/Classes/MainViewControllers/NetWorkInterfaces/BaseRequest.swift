//
//  BaseRequest.swift
//  SwiftCollection
//
//  Created by KeSen on 7/29/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import Alamofire
import SwiftyJSON

class BaseRequest: NSObject {
    func sleep(a: Int) -> Bool {
        return true
    }
    
    func request(url url: String) {
        
        let clientVersion = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"]
    
        let parameter = [ "clientId": "2"
                        , "uc" : "iphone"
                        , "cl": "11"
                        , "ve": clientVersion!]
        
        Alamofire.request(.GET, url, parameters: parameter).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}


