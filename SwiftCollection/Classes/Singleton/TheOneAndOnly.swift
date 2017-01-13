//
//  TheOneAndOnly.swift
//  SwiftCollection
//
//  Created by KeSen on 2016/11/10.
//  Copyright © 2016年 SenKe. All rights reserved.
//

import Foundation

// swift 定义单例步骤
// 1. 声明一个 let 类型的全局变量 sharedInstance
// 2. 声明 init 方法为私有，避免外部对象通过访问 init 方法创建单例类的其他实例

class TheOneAndOnly {
    static let sharedInstance = TheOneAndOnly()
    
    private init(){}
}
