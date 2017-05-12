//
//  FYFunctionButton.swift
//  date
//
//  Created by FLYang on 2017/2/8.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import Spring

protocol FYFunctionButtonDelegate {
    func functionButton(_ functionButtonAction: FYFunctionButton)
}

class FYFunctionButton: SpringButton {
    
    var delegate: FYFunctionButtonDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("重新记录", for: UIControlState.selected)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.adjustsImageWhenDisabled = false
        self.adjustsImageWhenHighlighted = false
        self.isSelected = false
        self.backgroundColor = UIColor.colorWithHex(MAIN_COLOR, alpha: 1)
        self.layer.cornerRadius = 50/2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.addTarget(self, action: #selector(functionButtonClick(_ :)), for: UIControlEvents.touchUpInside)
    }
    
    func setButtonTitle(_ title:String) {
        self.setTitle(title, for: UIControlState.normal)
    }
    
    func functionButtonClick(_ button:FYFunctionButton) {
        startSpringAnimation(button)
        
        if button.isSelected {
            self.backgroundColor = UIColor.colorWithHex(MAIN_COLOR)
            button.isSelected = false
            
        } else {
            self.backgroundColor = UIColor.colorWithHex(GRAY_COLOR_C)
            button.isSelected = true
        }
    }
    
    func startSpringAnimation(_ button:FYFunctionButton) {
        self.animation = "morph"
        self.curve = "easeIn"
        self.duration = 0.5
        self.animate()
        self.delegate?.functionButton(button)
    }
}
