//
//  ViewController.swift
//  XTimer
//
//  Created by X on 16/7/5.
//  Copyright © 2016年 XTimer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func click(sender: UIButton) {
        
        let vc = VC1()
        
        self.showViewController(vc, sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }


}

