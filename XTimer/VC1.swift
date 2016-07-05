//
//  VC1.swift
//  XTimer
//
//  Created by X on 16/7/5.
//  Copyright © 2016年 XTimer. All rights reserved.
//

import UIKit

let sw = UIScreen.mainScreen().bounds.size.width
let sh = UIScreen.mainScreen().bounds.size.height

class TimeModel: NSObject {
    
    var time = 0
    
    init(t:Int) {
        super.init()
        
        time = t
    }
}

class VC1: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let table = UITableView()
    
    var timer:XTimer!
    
    var arr:[TimeModel] = [TimeModel(t:15),TimeModel(t:90),TimeModel(t:65),TimeModel(t:200),TimeModel(t:30),TimeModel(t:25),TimeModel(t:10),TimeModel(t:99),TimeModel(t:126),TimeModel(t:175),TimeModel(t:34),TimeModel(t:222),TimeModel(t: 15)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.frame = CGRectMake(0, 0, sw, sh)
        
        table.backgroundColor = UIColor.whiteColor()
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        table.tableFooterView = view
        table.tableHeaderView = view
        
        table.delegate = self
        table.dataSource = self
        
        self.view.addSubview(table)
        
        table.registerNib(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        table.reloadData()
        
        timer = XTimer(interval: 1.0, block: { [weak self](o) in
            
            if self == nil {return}
            var end = true

            for item in self!.arr
            {
                if item.time >= 0
                {
                    item.time -= 1
                    end = false
                }
                
            }
            
            if end
            {
                o.cancel()
                self?.timer = nil
            }
            
            XTimer.MainDo({ [weak self](o) in
                
                self?.table.reloadData()
            })
            
        })
        
        timer.start()

    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        
        cell.model = arr[indexPath.row]
        
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    deinit
    {
        print("VC1 deinit !!!!!!!!!!!")
    }

}
