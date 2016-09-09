//
//  CellItem.swift
//  SKS_CollectionSwift
//
//  Created by KeSen on 7/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

class CellItem: NSObject {
    let name: String
    let objectClass: UIViewController.Type
    
    init(name: String, objectClass: UIViewController.Type) {
        self.name = name
        self.objectClass = objectClass
        
    }
}
