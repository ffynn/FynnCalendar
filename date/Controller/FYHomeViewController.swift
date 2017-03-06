//
//  FYHomeViewController.swift
//  date
//
//  Created by FLYang on 2017/2/8.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import BCColor
import FSCalendar
import SnapKit

class FYHomeViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, FYFunctionButtonDelegate {

    let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    
    var mainTable: UITableView!
    var functionButton: FYFunctionButton!
    var calenderView: FYCalendarView!
    var menuView: FYNavMenuView!
    
    
    /// 单元格的高度
    let CELL_HEIGHT: CGFloat = 95
    
    /// 根据当前月份显示单元格数量
    let tableRowsNumber : Int = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let monthString: String = formatter.string(from: NSDate() as Date)
        let month: Int! = Int(monthString)
        return month
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.gradientColor(CGPoint(x: 0.0, y: 0.0),
                                                          endPoint: CGPoint.init(x: 0.0, y: 1.0),
                                                             frame: self.view.frame,
                                                          colors: [UIColor.colorWithHex("FF9999")!, UIColor.white])
        
    }
    
    /// 页面标题
    func setControllerTitle() {
        let titleLable = UILabel.init()
        titleLable.font = UIFont.systemFont(ofSize: 17)
        titleLable.textColor = UIColor.white
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.text = "记录"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavMenuView()
        initCalendarView()
        initMainTableView()
        setFunctionButton()
    }
    
    /// 菜单按钮
    func initNavMenuView() {
        let menuView = FYNavMenuView(frame: CGRect(x: 0, y: 54, width: SCREEN_WIDTH, height: 40))
        self.view.addSubview(menuView)
        self.menuView = menuView
    }
    
    /// 日历视图
    func initCalendarView() {
        let calendarView = FYCalendarView.init(frame: CGRect.init())
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30)
            make.height.equalTo(SCREEN_WIDTH - 40)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.menuView.snp.bottom).offset(15)
        }
        self.calenderView = calendarView
    }
    
    /// 功能按钮
    func setFunctionButton() {
        let functionButton = FYFunctionButton(frame: CGRect(x: SCREEN_WIDTH - 65, y: SCREEN_HEIGHT - 65, width: 50, height: 50))
        functionButton.delegate = self
        self.view.addSubview(functionButton)
        self.functionButton = functionButton
    }
    
    func functionButton(_ functionButtonAction: FYFunctionButton) {
        if functionButtonAction.isSelected {
            print("关闭")
            
        } else {
            print("展开")
        }
    }
    
    /// 初始化记录列表
    func initMainTableView() {
        let mainTable = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        mainTable.backgroundColor = UIColor.colorWithHex("#FFFFFF", alpha: 0)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.showsVerticalScrollIndicator = false
        mainTable.separatorStyle = UITableViewCellSeparatorStyle.none
        mainTable.tableFooterView = UIView.init()
        self.view.addSubview(mainTable)
        self.mainTable = mainTable
        mainTable.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.left.equalTo(self.view).offset(0)
            make.top.equalTo(calenderView.snp.bottom).offset(10)
            make.bottom.equalTo(self.view).offset(-20)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FYMonthTableViewCell = FYMonthTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MainCellId")
        cell.setMonthDateModel(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

}
