//
//  BaseNavigationViewController.swift
//  OneLoginViewExample
//
//  Created by 刘练 on 2020/4/22.
//  Copyright © 2020 geetest. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.interactivePopGestureRecognizer?.delegate = self
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let interactivePopGestureRecognizer = self.interactivePopGestureRecognizer {
            if gestureRecognizer == interactivePopGestureRecognizer {
                if self.viewControllers.count < 2 {
                    return false
                }
                
                if self.viewControllers.count > 0 && self.visibleViewController == self.viewControllers[0] {
                    return false
                }
            }
        }
        
        return true
    }
}
