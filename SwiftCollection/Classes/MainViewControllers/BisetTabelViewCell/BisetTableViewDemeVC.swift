//
//  BisetTableViewDemeVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/29.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit

class BisetTableViewDemeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var itemsArray: [BisetSlideItem] = {
        let vc1 = UIViewController(nibName: "BitSlideVC1", bundle: nil)
        vc1.title = "命运石之"
        
        let vc2 = UIViewController(nibName: "BitSlideVC2", bundle: nil)
        vc2.title = "海棠叶"
        
        let vc3 = UIViewController(nibName: "BitSlideVC1", bundle: nil)
        vc3.title = "我是先锋"
        
        let item1 = BisetSlideItem(title: "命运石之", image: "device", viewController: vc1)
        let item2 = BisetSlideItem(title: "海棠叶", image: "control", viewController: vc2)
        let item3 = BisetSlideItem(title: "我是先锋", image: "device", viewController: vc3)
        
        return [item1, item2, item3]
    }()
    
    var headerView: BisetSlideHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(BisetSlideTableViewCell.self, forCellReuseIdentifier: "bisetTableViewCell")
    }
}

extension BisetTableViewDemeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return ScreenHeight * 2
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = BisetSlideHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 45))
            headerView.backgroundColor = UIColor.white
            headerView.slideItems = self.itemsArray
            headerView.itemClickEvent = { index in
                if let cell: BisetSlideTableViewCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? BisetSlideTableViewCell {
                    cell.scrollToIndex(index: index)
                }
            }
            
            self.headerView = headerView
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bisetTableViewCell", for: indexPath) as! BisetSlideTableViewCell
            cell.slideItems = self.itemsArray
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            cell.textLabel?.text = "我是你大爷"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    }
}

extension BisetTableViewDemeVC: BisetSlideTableViewCellDelegate {
    func scrolled(from: Int, to: Int) {
        self.headerView?.updateSlide(index: to)
    }
}
