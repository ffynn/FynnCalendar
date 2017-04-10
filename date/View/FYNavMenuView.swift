//
//  FYNavMenuView.swift
//  date
//
//  Created by FLYang on 2017/2/10.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import Spring

protocol FYNavMenuViewDelegate {
    func indexOfScroll(_ index: NSInteger)
}

class FYNavMenuView: UIView {
    
    var delegate: FYNavMenuViewDelegate!
    
    let menuButtonCount: Int = 2
    let menuButtonTag: Int = 100
    
    weak var calendarButton: UIButton!
    weak var statisticsButton: UIButton!
    weak var bottomLine: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.colorWithHex("#FFFFFF", alpha: 0)
        addMenuButton()
    }
    
    /// 菜单按钮
    func addMenuButton() {
        var menuTitleArr: [String] = ["日期", "统计"]

        for idx in 0 ..< menuButtonCount {
            let menuButton = SpringButton.init()
            menuButton.setTitle(menuTitleArr[idx], for: UIControlState.normal)
            menuButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            menuButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            menuButton.tag = idx + menuButtonTag
            self.addSubview(menuButton)
            menuButton.snp.makeConstraints { (make) in
                make.width.equalTo(60)
                make.right.equalTo(self.snp.centerX).offset(idx * 60)
                make.top.bottom.equalTo(self).offset(0)
            }
            menuButton.addTarget(self, action: #selector(menuSelectionAction(_ :)), for: UIControlEvents.touchUpInside)
        }
        
        addBottomLine()
    }
    
    func menuSelectionAction(_ button:SpringButton) {
        button.animation = "pop"
        button.curve = "easeIn"
        button.duration = 0.4
        button.animate()
        changeBottomLineLoc(button.tag - menuButtonTag)
    }
    
    /// 标志当前按钮的下划线
    func addBottomLine() {
        let bottomLine = UILabel.init()
        bottomLine.backgroundColor = UIColor.white
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(3)
            make.width.equalTo(25)
            make.right.equalTo(self.snp.centerX).offset(-17.5)
            make.bottom.equalTo(self).offset(0)
        }
        self.bottomLine = bottomLine
    }
    
    /// 下划线滚动改变位置
    ///
    /// - Parameter index: 点击的第几个按钮
    func changeBottomLineLoc(_ index: NSInteger) {
        self.delegate?.indexOfScroll(index)
        UIView.animate(withDuration: 0.2) {
            self.bottomLine.snp.updateConstraints { (make) in
                make.right.equalTo(self.snp.centerX).offset(-17.5 + CGFloat(index * 60))
            }
            self.layoutIfNeeded()
        }
    }

}
