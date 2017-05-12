//
//  ViewController.swift
//  date
//
//  Created by FLYang on 2017/2/7.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    
    var Counter = 0.0
    var Timer = Foundation.Timer()
    var IsPlaying = false
    var timeLabel = UILabel()
    var startButton = UIButton()
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        self.view = view
        
        self.loadShowTimeLabel()
        self.loadStartButton()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 显示时间文本
    func loadShowTimeLabel() {
        timeLabel.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height:100)
        timeLabel.text = String(Counter)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 32)
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.black
        timeLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(timeLabel)
    }
    
    /// 加载开始按钮
    func loadStartButton() {
        startButton.frame = CGRect(x: SCREEN_WIDTH/4, y: timeLabel.frame.maxY + 20, width: SCREEN_WIDTH/2, height:40)
        startButton.backgroundColor = UIColor.orange
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        startButton.setTitle("开始", for: UIControlState.normal)
        startButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        startButton.addTarget(self, action: #selector(startTime), for: UIControlEvents.touchUpInside)
        self.view.addSubview(startButton)
    }
    
    /// 开始计时
    func startTime() {
        if(IsPlaying) {
            return
        }
        startButton.isEnabled = false
        Timer = Foundation.Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
    
    /// 更新时间
    func updateTime() {
        Counter += 0.1
        timeLabel.text = String(format:"%.1f", Counter)
    }

}

