//
//  FYDiyCalendarCell.swift
//  date
//
//  Created by FLYang on 2017/2/9.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import Foundation
import FSCalendar

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class FYDiyCalendarCell: FSCalendarCell {
    
    weak var todayImageView: UIImageView!
    weak var selectedLayer: CAShapeLayer!
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        
        let todayImageView = UIImageView(image: UIImage(named: "icon_crosshair")!)
        self.contentView.insertSubview(todayImageView, at: 0)
        todayImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.centerX.centerY.equalTo(self.contentView)
        }
        self.todayImageView = todayImageView
        
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.colorWithHex("#FF9999")?.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel!.layer)
        self.selectedLayer = selectionLayer

        self.shapeLayer.isHidden = true
        
        let backView = UIView(frame: self.bounds)
        backView.backgroundColor = UIColor.white
        self.backgroundView = backView
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = self.contentView.bounds
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.selectedLayer.frame = self.contentView.bounds
        
        let bounds_rect: CGRect = self.selectedLayer.bounds
        let bounds_width: CGFloat = self.selectedLayer.frame.width
        let bounds_height: CGFloat = self.selectedLayer.frame.height
        
        if selectionType == .middle {
            self.selectedLayer.path = UIBezierPath(rect: bounds_rect).cgPath
        
        } else if selectionType == .leftBorder {
            self.selectedLayer.path = UIBezierPath(roundedRect: bounds_rect,
                                             byRoundingCorners: [.topLeft, .bottomLeft],
                                                   cornerRadii: CGSize(width: bounds_width / 2, height: bounds_height / 2)).cgPath
        
        } else if selectionType == .rightBorder {
            self.selectedLayer.path = UIBezierPath(roundedRect: bounds_rect,
                                             byRoundingCorners: [.topRight, .bottomRight],
                                                   cornerRadii: CGSize(width: bounds_width / 2, height: bounds_height / 2)).cgPath
        
        } else if selectionType == .single {
            let diameter: CGFloat = min(bounds_height, bounds_width)
            let ovaRect: CGRect = CGRect.init(x: bounds_width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
            self.selectedLayer.path = UIBezierPath.init(ovalIn: ovaRect).cgPath
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        if self.placeholder {
            self.eventIndicator.isHidden = true
            self.titleLabel.textColor = UIColor.colorWithHex("#CCCCCC")
        }
    }

}
