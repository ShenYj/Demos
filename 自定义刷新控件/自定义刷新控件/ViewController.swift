//
//  ViewController.swift
//  自定义刷新控件
//
//  Created by ShenYj on 16/7/1.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var dataArr: [AnyObject] = {
        let arr = [1,2,3,4,5]
        return arr
    }() //模拟数据
    let refresh: JSRefresh = JSRefresh()  //自定义刷新控件
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
        //设置视图
        setupUI()
        
    }
    
    private func setupUI () {

        //添加控件
        tableView.addSubview(refresh)
        
        refresh.addTarget(self, action: #selector(refreshAction), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    @objc private func refreshAction () {
        
        // 模拟网络延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            
            // 请求数据
            self.dataArr += self.dataArr
            self.tableView.reloadData()
            // 结束刷新
            self.refresh.endRefreshing()
        }

        
    }


}

extension ViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("id", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

