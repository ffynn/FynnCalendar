//
//  FYTimeDataCollectionViewCell.swift
//  date
//
//  Created by FLYang on 2017/5/11.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import SwiftDate

class FYTimeDataCollectionViewCell: UICollectionViewCell {
    
    weak var monthLabel: UILabel!
    weak var dayLabel: UILabel!
    weak var stateLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.gradientColor(CGPoint(x: 0.0, y: 0.0),
                                                     endPoint: CGPoint.init(x: 0.0, y: 1.0),
                                                     frame: self.frame,
                                                     colors: [UIColor.colorWithHex(MAIN_COLOR)!, UIColor.colorWithHex(MAIN_COLOR, alpha: 0.3)!])
        
        setMonthLabel()
        setDayLabel()
        setStateLabel()
    }
    
    /// 设置数据
    ///
    /// - Parameter model: 记录的日期数据
    func setViewCellModel(_ model: FYTimeRecordData) {
        self.monthLabel.text = model.pk
        
        let state = model.state!.stateName
        self.stateLabel.text = state
        
        if state.isEqual("添加新记录") {
            self.dayLabel.text = "＋"
        } else if state.isEqual("进入姨妈期") {
            self.dayLabel.text = calculatedDateInterval((model.come?.comeDate)!)
        } else if state.isEqual("大姨妈走了") {
            self.dayLabel.text = calculatedDateInterval((model.leave?.leaveDate)!)
        }

    }
    
    
    /// 提取日期中的天
    func calculatedDateInterval(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nowDate = dateFormatter.date(from: date)!
        return String(nowDate.day)
    }
    
    /// 设置视图的其他控件
    func setMonthLabel() {
        let month = UILabel.init()
        month.font = UIFont.systemFont(ofSize: 14)
        month.textColor = UIColor.colorWithHex(BLACK_COLOR_6)
        month.backgroundColor = UIColor.colorWithHex(WHITE_COLOR)
        month.textAlignment = NSTextAlignment.center
        self.addSubview(month)
        month.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.left.right.equalTo(self).offset(0)
        }
        self.monthLabel = month
    }
    
    func setDayLabel() {
        let day = UILabel.init()
        day.font = UIFont.boldSystemFont(ofSize: 50)
        day.textColor = UIColor.colorWithHex(WHITE_COLOR)
        day.textAlignment = NSTextAlignment.center
        self.addSubview(day)
        day.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.left.right.equalTo(self).offset(0)
            make.centerX.centerY.equalTo(self)
        }
        self.dayLabel = day
    }
    
    func setStateLabel() {
        let state = UILabel.init()
        state.font = UIFont.systemFont(ofSize: 12)
        state.textColor = UIColor.colorWithHex(WHITE_COLOR)
        state.textAlignment = NSTextAlignment.center
        self.addSubview(state)
        state.snp.makeConstraints { (make) in
            make.height.equalTo(15)
            make.bottom.equalTo(self).offset(-20)
            make.left.right.equalTo(self).offset(0)
        }
        self.stateLabel = state
    }
}
