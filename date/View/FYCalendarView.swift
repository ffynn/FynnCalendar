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
        
        self.backgroundColor = UIColor.colorWithHex("#FFFFFF", alpha: 1)
        self.layer.cornerRadius = 10
    
        let calendar = FSCalendar.init()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        self.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.bottom.right.equalTo(self).offset(-10)
        }
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = UIColor.white
        calendar.calendarWeekdayView.backgroundColor = UIColor.white
        calendar.clipsToBounds = true
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.appearance.headerDateFormat = "yyyy年 MM月"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerTitleColor = UIColor.colorWithHex("#333333")
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16)
        calendar.appearance.weekdayTextColor = UIColor.colorWithHex("#666666")
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.register(FYDiyCalendarCell.self, forCellReuseIdentifier: "calendarCell")
        calendar.swipeToChooseGesture.isEnabled = true
        
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(getter: calendar.scopeGesture));
        calendar.addGestureRecognizer(scopeGesture)
        
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
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
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
