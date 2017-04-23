//
//  FYStatisticalViewController.swift
//  date
//
//  Created by FLYang on 2017/4/7.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit

class FYStatisticalViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
