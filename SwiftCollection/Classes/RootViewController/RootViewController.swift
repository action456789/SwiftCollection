//
//  RootViewController.swift
//  SKS_CollectionSwift
//
//  Created by KeSen on 7/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController {

    override func viewDidLoad() {
        view.addSubview(tableView)
    }
    
    var tableView: UITableView {
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RootCell")
        
        return tableView
    }
    
    var dataArray: [CellItem] {
        let array = [CellItem.init(name: "Alamofire 网络请求", objectClass: NetWorkInterfaceDemo.self)
                    ,CellItem.init(name: "RxSwift", objectClass: RxSwiftDemoViewController.self)
                    ,CellItem.init(name: "UIView 关键帧动画", objectClass: AnimateDomeViewController.self)
                    ,CellItem.init(name: "RAC 测试", objectClass: RACDemoVC.self)
                    ,CellItem.init(name: "下拉透明导航栏", objectClass: GraduallyTransparentVC.self)
                    ,CellItem.init(name: "水波纹", objectClass: WaterRipplesDemoVC.self)
                    ,CellItem.init(name: "雷达效果", objectClass: RadarViewController.self)
                    ,CellItem.init(name: "下雨与雪花效果", objectClass: Snow_RainDemeVC.self)
                    ,CellItem.init(name: "最小子序列", objectClass: LCSDemoViewController.self)
                    ,CellItem.init(name: "滑动分栏框架", objectClass: BisetSlideDemoVC.self)
                    ,CellItem.init(name: "TableViewCell 滑动分栏框架", objectClass: BisetTableViewDemeVC.self)
                ]
        return array
    }
}

// MARK: Table View Delegate

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let obj: UIViewController? = dataArray[indexPath.row].objectClass.init()
        if let objValue = obj {
            objValue.title = dataArray[indexPath.row].name
            self.navigationController!.pushViewController(objValue, animated: true)
        }
    }
}

// MARK: Table View DataSource

extension RootViewController: UITableViewDataSource {
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = dataArray[indexPath.row].name
        
        return cell
    }
}
