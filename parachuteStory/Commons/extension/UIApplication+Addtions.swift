//
//  UIApplication+Addtions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import UIKit

extension UIApplication {
    static var topViewController: UIViewController? {
        return _topViewController(UIApplication.shared.keyWindow?.rootViewController)
    }

    static var topViewControllerNoAlert: UIViewController? {
        return _topViewController(UIApplication.shared.keyWindow?.rootViewController,
                                  ignoreAlert: true)
    }

    private static func _topViewController(_ controller: UIViewController?,
                                           ignoreAlert: Bool = false) -> UIViewController? {
        if let navController = controller as? UINavigationController {
            return _topViewController(navController.visibleViewController)
        }

        if let tabbarController = controller as? UITabBarController {
            return _topViewController(tabbarController.selectedViewController)
        }

        if let childController = controller?.children.last {
            return _topViewController(childController)
        }

        if let presentedController = controller?.presentedViewController {
            if presentedController.isKind(of: UIAlertController.self), !ignoreAlert {
                return _topViewController(presentedController)
            }
        }

        return controller
    }
}

private func sp_checkInfo() {
    print("Get Info Success")
}
