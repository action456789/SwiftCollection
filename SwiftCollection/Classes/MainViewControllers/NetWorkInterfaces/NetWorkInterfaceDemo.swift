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


