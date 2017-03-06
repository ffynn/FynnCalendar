//
//  FYMonthTableViewCell.swift
//  date
//
//  Created by FLYang on 2017/2/7.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import BCColor

class FYMonthTableViewCell: UITableViewCell {
    
    let CELL_WIDTH: CGFloat = FYHomeViewController().SCREEN_WIDTH
    let CELL_HEIGHT: CGFloat = FYHomeViewController().CELL_HEIGHT
    
    weak var backView: UIView!
    weak var monthLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.backgroundColor = UIColor.colorWithHex("#FFFFFF", alpha: 0)
        setCellViewUI()
    }
    
    /// 设置UI
    func setCellViewUI() {
        setCellViewUIControl()
    }
    
    /// 视图控件
    func setCellViewUIControl() {
        let backView = UIView(frame: CGRect(x: 15, y: 15, width: CELL_WIDTH - 30, height: 80))
        backView.layer.cornerRadius = 10
        backView.backgroundColor = UIColor.gradientColor(CGPoint(x: 0.0, y: 0.0),
                                                         endPoint: CGPoint.init(x: 1.0, y: 0.0),
                                                            frame: backView.frame,
                                                           colors: [UIColor.colorWithHex("FF9999")!, UIColor.white])
        self.addSubview(backView)
        self.backView = backView
        
        let monthLable = UILabel.init()
        monthLable.font = UIFont.boldSystemFont(ofSize: 32)
        monthLable.textAlignment = NSTextAlignment.center
        monthLable.textColor = UIColor.white
        self.addSubview(monthLable)
        monthLable.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.backView).offset(10)
            make.bottom.equalTo(self.backView).offset(-10)
            make.width.equalTo(70)
        }
        self.monthLabel = monthLable
    }
    
    func setMonthDateModel(_ month: Int) {
        self.monthLabel.text = String(format: "%d月", (month + 1))
    }
    
}
