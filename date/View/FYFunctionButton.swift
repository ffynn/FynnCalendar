//
//  FYFunctionButton.swift
//  date
//
//  Created by FLYang on 2017/2/8.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit
import Spring

//@objc public protocol LiquidFloatingActionButtonDataSource {
//    func numberOfCells(_ liquidFloatingActionButton: LiquidFloatingActionButton) -> Int
//    func cellForIndex(_ index: Int) -> LiquidFloatingCell
//}

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
        self.setImage(UIImage(named: "icon_function_open"), for: UIControlState.normal)
        self.adjustsImageWhenDisabled = false
        self.adjustsImageWhenHighlighted = false
        self.isSelected = false
        self.backgroundColor = UIColor.colorWithHex("FF9999", alpha: 1)
        self.layer.cornerRadius = 50/2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.addTarget(self, action: #selector(functionButtonClick(_ :)), for: UIControlEvents.touchUpInside)
    }
    
    func functionButtonClick(_ button:FYFunctionButton) {
        
        startSpringAnimation(button)
        
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        if button.isSelected {
            anim.toValue = M_PI * (180/180.0)
            self.backgroundColor = UIColor.colorWithHex("FF9999", alpha: 1)
            button.isSelected = false
            
        } else {
            anim.toValue = M_PI * (135/180.0)
            self.backgroundColor = UIColor.colorWithHex("B26969", alpha: 1)
            button.isSelected = true
        }
        
        anim.duration = 0.3
        anim.isRemovedOnCompletion = false
        anim.fillMode = "forwards"
        self.layer.add(anim, forKey: "rotationAnimation")
    }
    
    func startSpringAnimation(_ button:FYFunctionButton) {
        self.animation = "morph"
        self.curve = "easeIn"
        self.duration = 0.5
        self.animate()
        self.delegate?.functionButton(button)
    }

}
