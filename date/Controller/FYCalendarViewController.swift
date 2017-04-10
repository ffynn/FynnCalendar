//
//  FYCalendarViewController.swift
//  date
//
//  Created by FLYang on 2017/4/7.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit

class FYCalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FYFunctionButtonDelegate {
    
    var mainTable: UITableView!
    var calenderView: FYCalendarView!
    var functionButton: FYFunctionButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCalendarView()
        initMainTableView()
        setFunctionButton()
    }
    
    /// 功能按钮
    private func setFunctionButton() {
        let functionButton = FYFunctionButton(frame: CGRect(x: SCREEN_WIDTH - 65, y: SCREEN_HEIGHT - 65, width: 50, height: 50))
        functionButton.delegate = self
        self.view.addSubview(functionButton)
        functionButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50, height: 50))
            make.right.equalTo(self.view).offset(-15)
            make.bottom.equalTo(self.view).offset(-10)
        }
        self.functionButton = functionButton
    }
    
    func functionButton(_ functionButtonAction: FYFunctionButton) {
        if functionButtonAction.isSelected {
            print("关闭")
            
        } else {
            print("展开")
        }
    }

    /// 日历视图
    func initCalendarView() {
        let calendarView = FYCalendarView.init(frame: CGRect.init())
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30)
            make.height.equalTo(SCREEN_WIDTH - 40)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(10)
        }
        self.calenderView = calendarView
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
        mainTable.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.left.equalTo(self.view).offset(0)
            make.top.equalTo(calenderView.snp.bottom).offset(10)
            make.bottom.equalTo(self.view).offset(-5)
        }
        self.mainTable = mainTable
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
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
