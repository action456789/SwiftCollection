//
//  RootViewController.swift
//  SKS_CollectionSwift
//
//  Created by KeSen on 7/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController {
    
    var tableView: UITableView {
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50;
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "RootCell")
        return tableView
    }
    
    var dataArray: [CellItem] {
        let array = [CellItem.init(name: "Alamofire 网络请求", objectClass: NetWorkInterfaceDemo.self)]
        return array
    }
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
    }
}

// MARK: Table View Delegate

extension RootViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let obj: UIViewController? = dataArray[indexPath.row].objectClass.init()
        if let objValue = obj {
            objValue.title = dataArray[indexPath.row].name
            self.navigationController!.pushViewController(objValue, animated: true)
        }
    }
}

// MARK: Table View DataSource

extension RootViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RootCell", forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = dataArray[indexPath.row].name
        
        return cell
    }
}