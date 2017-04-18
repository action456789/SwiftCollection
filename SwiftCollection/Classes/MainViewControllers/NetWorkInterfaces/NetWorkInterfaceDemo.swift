//
//  NetWorkInterfaceDemo.swift
//  SwiftCollection
//
//  Created by KeSen on 7/29/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

class NetWorkInterfaceDemo: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://mapi.tv.funshion.com/v2/index/"
        let request = BaseRequest()
        request.request(url: url)
    }
    
}


