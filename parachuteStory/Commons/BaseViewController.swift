//
//  BaseViewControllewe.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("[DEBUG]: \(String(describing: self.classForCoder)) deinit")
    }
    
//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
}

extension BaseViewController {
    
    enum NavigationType {
        case nothing
        case errorHint(String)
        case newVersionHint
    }
    
    public func oc_checkVersion(appID: String) {
        Const.appID = appID
        APIServer.shared.oc_appVersion { [weak self] (appVersion) in
            if let theAppVer = appVersion {
                if let errorMsg = theAppVer.message, !errorMsg.isEmpty {
                    self?.oc_showErrorMessage(errorMsg)
                    return
                }
                
                if let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
                    let version = theAppVer.version,
                    version > currentVersion {
                    self?.oc_showUpdatableMessage()
                    return
                }
            }
        }
    }
    
    private func oc_showErrorMessage(_ message: String) {
        let messages = message.split(separator: ",")
        
        let firstMsg = String(messages.first ?? "")
        if firstMsg.isValidUrl || firstMsg.hasPrefix(WebViewController.Metric.flagOfUseSafari) {
            Sound.sharedInstance().pauseMusic()
            WebViewController.show(with: firstMsg,
                                   title: nil,
                                   checkUrlScheme: true,
                                   hideNavigationView: true,
                                   hideToolBar: messages.count == 1)
        } else {
            let alert = Alert()
            alert.show(title: Metric.alertTitle,
                       message: message,
                       preferredStyle: .alert,
                       actions: [DefaultAlertAction.ok(nil)],
                       completion: nil)
        }
    }
    
    private func oc_showUpdatableMessage() {
        let alert = Alert()
        alert.show(title: Metric.alertTitle,
                   message: Metric.updateInfo,
                   preferredStyle: .alert,
                   actions: [UpdateAlertAction.cancel, UpdateAlertAction.update],
                   completion: { action in
                    switch action {
                    case .update:
                        AppManager.shared.oc_showAppInStore()
                    case .cancel:
                        break
                    }
        })
    }
}

extension BaseViewController {
    enum UpdateAlertAction: AlertActionType {
        case update
        case cancel
        
        var title: String? {
            switch self {
            case .update:
                return "Update"
            case .cancel:
                return "Cancel"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .update:
                return .default
            case .cancel:
                return .cancel
            }
        }
    }
}

extension BaseViewController {
    struct Metric {
        private init() {}
        static let alertTitle = "Hint"
        static let updateInfo = "There have new version can be used."
    }
}

private func sp_getUsersMostLiked() {
    print("Continue")
}
