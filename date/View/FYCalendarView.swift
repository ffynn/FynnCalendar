//
//  FYCalendarView.swift
//  date
//
//  Created by FLYang on 2017/2/9.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import FSCalendar

class FYCalendarView: UIView, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    /// 当前选择的日期
    var selectDay: String!
    let todayDate = NSDate.init(timeIntervalSinceNow: 0)
    
    /// 转换日期格式
    let gregorian = Calendar(identifier: .gregorian)
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    weak var calendar: FSCalendar!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectDay = self.formatter.string(from: self.todayDate as Date)
        
        self.backgroundColor = UIColor.colorWithHex(WHITE_COLOR, alpha: 1)
        self.layer.cornerRadius = 10
    
        let calendar = FSCalendar.init()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        calendar.clipsToBounds = true
        calendar.swipeToChooseGesture.isEnabled = true
        
        calendar.calendarHeaderView.backgroundColor = UIColor.white
        calendar.appearance.headerDateFormat = "yyyy年 MM月"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerTitleColor = UIColor.colorWithHex(BLACK_COLOR_3)
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16)
        
        calendar.calendarWeekdayView.backgroundColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.appearance.weekdayTextColor = UIColor.colorWithHex(BLACK_COLOR_6)
        calendar.appearance.titleWeekendColor = UIColor.colorWithHex(MAIN_COLOR)
        calendar.register(FYDiyCalendarCell.self, forCellReuseIdentifier: "calendarCell")
        
        self.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.bottom.right.equalTo(self).offset(-10)
        }
        self.calendar = calendar

    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let diyCell = (cell as! FYDiyCalendarCell)

        diyCell.todayImageView.isHidden = !self.gregorian.isDateInToday(date)

        if position == .current {

            var selectionType = SelectionType.none
            
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
                    
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    } else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    } else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    } else {
                        selectionType = .single
                    }
                }
                
            } else {
                selectionType = .none
            }
            
            if selectionType == .none {
                diyCell.selectedLayer.isHidden = true
                return
            }
            diyCell.selectedLayer.isHidden = false
            diyCell.selectionType = selectionType
            
        } else {
            diyCell.todayImageView.isHidden = true
            diyCell.selectedLayer.isHidden = true
        }
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if self.gregorian.isDateInToday(date) {
            return ""
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "calendarCell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectDay = self.formatter.string(from: date)
        if self.gregorian.isDateInToday(date) {
            print("点击了今天 \(self.formatter.string(from: date))")
        }
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectDay = self.formatter.string(from: self.todayDate as Date)
        if self.gregorian.isDateInToday(date) {
            print("取消了今天 \(self.formatter.string(from: date))")
        }
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.black]
        }
        return [appearance.eventDefaultColor]
    }
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date, at: position)
        }
    }
}
