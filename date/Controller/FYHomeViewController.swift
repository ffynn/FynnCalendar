//
//  FYHomeViewController.swift
//  date
//
//  Created by FLYang on 2017/2/8.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit

class FYHomeViewController: FYBaseViewController, UIScrollViewDelegate, FYNavMenuViewDelegate {

    var functionButton: FYFunctionButton!
    var menuView: FYNavMenuView!
    var homeRollView: UIScrollView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.gradientColor(CGPoint(x: 0.0, y: 0.0),
                                                          endPoint: CGPoint.init(x: 0.0, y: 1.0),
                                                             frame: self.view.frame,
                                                            colors: [UIColor.colorWithHex(MAIN_COLOR)!, UIColor.colorWithHex(MAIN_COLOR_FE)!])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavMenuView()
        setHomeRollView()
    }
    
    /// 首页滚动视图
    private func setHomeRollView() {
        self.homeRollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        self.homeRollView.delegate = self
        self.homeRollView.backgroundColor = UIColor.colorWithHex("#FFFFFF", alpha: 0)
        self.homeRollView.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: 0)
        self.homeRollView.isPagingEnabled = true
        self.homeRollView.isScrollEnabled = false
        self.view.addSubview(self.homeRollView)
        
        let calendarVC = FYCalendarViewController.init()
        self.homeRollView.addSubview(calendarVC.view)
        
        let statisticalVC = FYStatisticalViewController.init()
        self.homeRollView.addSubview(statisticalVC.view)
    }

    /// 菜单按钮
    private func setNavMenuView() {
        let menuView = FYNavMenuView(frame: CGRect(x: 0, y: 24, width: SCREEN_WIDTH, height: 40))
        menuView.delegate = self
        self.view.addSubview(menuView)
        self.menuView = menuView
    }
    
    func indexOfScroll(_ index: NSInteger) {
        var rollPoint = self.homeRollView.contentOffset
        rollPoint.x = CGFloat(Int(SCREEN_WIDTH) * index)
        UIView.animate(withDuration: 0.3) { 
            self.homeRollView.contentOffset = rollPoint
        }
    }

}
