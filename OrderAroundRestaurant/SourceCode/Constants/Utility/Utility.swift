//
//  Utility.swift
//  orderAround
//
//  Created by Prem's on 28/08/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import UIKit

class Utility{
    
    static let instance = Utility()
    
    func topViewControllerWithRootViewController(rootViewController: UIViewController) -> UIViewController {
        if let tabbarController = rootViewController as? UITabBarController, let selectedViewController = tabbarController.selectedViewController{
            return self.topViewControllerWithRootViewController(rootViewController: selectedViewController)
        } else if
            let navigationController = rootViewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topViewControllerWithRootViewController(rootViewController: visibleViewController)
        } else if let presentedController = rootViewController.presentedViewController {
            return self.topViewControllerWithRootViewController(rootViewController: presentedController)
        } else {
            return rootViewController
        }
    }
}
