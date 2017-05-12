//
//  FYCalendarViewController.swift
//  date
//
//  Created by FLYang on 2017/4/7.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftDate

class FYCalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FYFunctionButtonDelegate {
    
    let UICollectionViewCellId = "TimeCollectionViewCellId"
    
    var timeCollection: UICollectionView!
    var calenderView: FYCalendarView!
    var functionButton: FYFunctionButton!
    var timeDataResults: Results<FYTimeRecordData>?
    
    /// 转换日期格式
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    /// 单元格的大小
    let CELL_WIDTH: CGFloat = CGFloat((SCREEN_WIDTH - 50)/3)
    let CELL_HEIGHT: CGFloat = CGFloat((SCREEN_WIDTH - 50)/3) * 1.52
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCalendarView()
        initTimeCollectionView()
//        setRealmData()
        getRealmData()
        setCollectionScrollIndex()
        setFunctionButton()
    }
    
    /// 获取数据库所有记录
    func getRealmData() {
        let realmResult = try! Realm()
        let items = realmResult.objects(FYTimeRecordData.self)
        if items.count > 0 {
            /// 获取所有的记录
            timeDataResults = realmResult.objects(FYTimeRecordData.self)
            return
        }
    }
    
    /// 查询数据库插入数据
    func setRealmData() {
        let realm = try! Realm()
        
        for idx in 1...12 {
            let timeState = FYTimeStateData()
            timeState.stateName = "添加新记录"
            
            let timeCome = FYTimeComeData()
            timeCome.comeDate = ""
            
            let timeLeave = FYTimeLeaveData()
            timeLeave.leaveDate = ""
            
            let useDay = FYTimeUseDayData()
            useDay.useDay = 0
            
            /// 创建日期记录
            let timeData = FYTimeRecordData()
            timeData.pk = String.init(format: "%d月", idx)
            timeData.state = timeState
            timeData.come = timeCome
            timeData.leave = timeLeave
            timeData.day = useDay
            
            /// 数据持久化操作
            try! realm.write {
                realm.add(timeData)
            }

        }

    }
    
    /// 通过当前日期月份设置记录列表滚动的位置
    func setCollectionScrollIndex() {
        let currentDate = Date()
        let index = currentDate.month
        let newIndexPath = IndexPath.init(item: index, section: 0)
        self.timeCollection.scrollToItem(at: newIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        print(index)
    }
    
    /// 功能按钮
    private func setFunctionButton() {
        let functionButton = FYFunctionButton()
        functionButton.delegate = self
        functionButton .setButtonTitle("大姨妈来了")
        self.view.addSubview(functionButton)
        functionButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 50))
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-15)
        }
        self.functionButton = functionButton
    }
    
    func functionButton(_ functionButtonAction: FYFunctionButton) {
        if functionButtonAction.isSelected {
            print("重新记录", self.calenderView.selectDay)
            
        } else {
            print("记录", self.calenderView.selectDay)
        }
    }

    /// 日历视图
    func initCalendarView() {
        let calendarView = FYCalendarView.init(frame: CGRect.init(x: 15, y: 10, width: SCREEN_WIDTH - 30, height: SCREEN_WIDTH - 40))
        self.view.addSubview(calendarView)
//        calendarView.snp.makeConstraints { (make) in
//            make.width.equalTo(SCREEN_WIDTH - 30)
//            make.height.equalTo(SCREEN_WIDTH - 40)
//            make.centerX.equalTo(self.view)
//            make.top.equalTo(self.view.snp.top).offset(10)
//        }
        self.calenderView = calendarView
    }

    /// 初始化记录列表
    func initTimeCollectionView() {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize.init(width: CELL_WIDTH, height: CELL_HEIGHT)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        flowLayout.minimumInteritemSpacing = 10
        let timeCollection = UICollectionView.init(frame: CGRect.init(x: 0, y: self.calenderView.frame.maxY + 15, width: SCREEN_WIDTH, height: CELL_HEIGHT), collectionViewLayout: flowLayout)
        timeCollection.backgroundColor = UIColor.colorWithHex("#FFFFFF", alpha: 0)
        timeCollection.delegate = self
        timeCollection.dataSource = self
        timeCollection.showsHorizontalScrollIndicator = false
        timeCollection.register(FYTimeDataCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCellId)
        self.view.addSubview(timeCollection)
        self.timeCollection = timeCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.timeDataResults!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCellId, for: indexPath) as! FYTimeDataCollectionViewCell
        cell .setViewCellModel(self.timeDataResults![indexPath.row])
        return cell
    }
}
