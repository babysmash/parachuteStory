//
//  Alert.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/19.
//

import Foundation
import UIKit

// ----- AlertActionType -----

protocol AlertActionType {
    var title: String? { get }
    var style: UIAlertAction.Style { get }
}

extension AlertActionType {
    var style: UIAlertAction.Style {
        return .default
    }
}

// ----- Action -----

enum DefaultAlertAction: AlertActionType {
    case ok(Error?)
    case no
    case yes

    var title: String? {
        switch self {
        case .ok:
            return "OK"
        case .no:
            return "NO"
        case .yes:
            return "YES"
        }
    }

    var style: UIAlertAction.Style {
        switch self {
        case .no:
            return .cancel
        default:
            return .default
        }
    }
}

enum ChineseAlertAction: AlertActionType {
    case ok
    case cancel
    
    var title: String? {
        switch self {
        case .ok:
            return "确定"
        default:
            return "取消"
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        default:
            return .default
        }
    }
}

// ----- Alert -----

protocol AlertType: AnyObject {
    func show<Action: AlertActionType>(title: String?,
                                       message: String?,
                                       fromVC: UIViewController?,
                                       preferredStyle: UIAlertController.Style,
                                       actions: [Action],
                                       completion: ((Action) -> Void)?)
}

final class Alert: AlertType {

    func show<Action>(title: String?,
                      message: String?,
                      fromVC: UIViewController? = nil,
                      preferredStyle: UIAlertController.Style,
                      actions: [Action],
                      completion: ((Action) -> Void)? = nil) where Action: AlertActionType {
        guard let message = message else { return }
        Alert.makeAlertController(title: title,
                                  message: message,
                                  fromVC: fromVC,
                                  preferredStyle: preferredStyle,
                                  actions: actions,
                                  completion: completion)
    }

    @discardableResult
    private static func makeAlertController<Action>(title: String?,
                                                    message: String?,
                                                    fromVC: UIViewController? = nil,
                                                    preferredStyle: UIAlertController.Style,
                                                    actions: [Action],
                                                    completion: ((Action) -> Void)?) -> UIAlertController where Action: AlertActionType {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                completion?(action)
            }
            alert.addAction(alertAction)
        }

        if fromVC == nil {
            UIApplication.topViewController?.present(alert, animated: true, completion: nil)
        } else {
            fromVC?.present(alert, animated: true, completion: nil)
        }

        return alert
    }
}

private func sp_didGetInfoSuccess() {
    print("Get Info Success")
}
