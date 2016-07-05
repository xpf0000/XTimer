//
//  TableViewCell.swift
//  XTimer
//
//  Created by X on 16/7/5.
//  Copyright © 2016年 XTimer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var time: UILabel!
    
    var model:TimeModel!
    {
        didSet
        {
            //timer?.cancel()
            
            if model.time < 0
            {
                time.text = "已完成"
            }
            else
            {
                time.text = "\(model.time)"
            }
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
