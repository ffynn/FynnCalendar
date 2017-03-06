//
//  FYMainTabBarController.swift
//  date
//
//  Created by FLYang on 2017/2/7.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import UIKit

class FYMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBarViewControllers()
    }
    
    func setTabBarViewControllers() {
        self.setChildViewController(viewController: FYHomeViewController(),
                                    itemTitle: "记录",
                                    itemImage: "tabBar_home_default",
                                    itmeSelectedImage: "tabBar_home_selected")
        
        self.setChildViewController(viewController: ViewController(),
                                    itemTitle: "分析",
                                    itemImage: "tabBar_home_default",
                                    itmeSelectedImage: "tabBar_home_selected")
        
        let attributes = [NSForegroundColorAttributeName : UIColor.black]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: UIControlState.selected)
    }
    
    func setChildViewController(viewController: UIViewController,
                                     itemTitle: String,
                                     itemImage: String,
                             itmeSelectedImage: String) {

        let selectedImage: UIImage = (UIImage(named: itmeSelectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!
        
        viewController.tabBarItem = UITabBarItem(title: itemTitle,
                                                 image: UIImage(named: itemImage),
                                         selectedImage: selectedImage)
        
        let nav = FYMainNavigationController(rootViewController: viewController)
        
        self.addChildViewController(nav)
    }

}
