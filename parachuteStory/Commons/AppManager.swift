//
//  AppManager.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import UIKit
import StoreKit

final class AppManager {
    init() {}
    static let shared = AppManager()
}

extension AppManager {
    func oc_showAppInStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(Const.appID)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func oc_rateUs() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(Const.appID)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func oc_dealWithAdvertisementTap(actionUrl: String) {
        guard actionUrl.isValidUrl,
            let url = URL(string: actionUrl) else {
            return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

private func sp_checkUserInfo() {
    print("Get Info Success")
}
