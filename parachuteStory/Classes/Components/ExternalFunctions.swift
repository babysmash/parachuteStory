//
//  ExternalFunctions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import Foundation

class ExternalFunctions {
    
    //MARK: - Game Center
    
    static func showLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
    }
    
    static func getLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getLeaderboard"), object: nil)
    }
    
    static func hideLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hideGameScoreTableView"), object: nil)
    }
    
    static func submitScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "submitScore"), object: nil)
    }
    
    static func getWorldBestScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getWorldBestScore"), object: nil)
    }
    
    //MARK: - Rate Us
    
    static func rateUs() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUs"), object: nil)
    }
    
    static func rateUsAfterGame() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUs"), object: nil)
    }
    
    //MARK: - Sharing
    
    static func share() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "share"), object: nil)
    }
    
    //MARK: - In-Apps
    
    static func buyRemoveAds() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "buyRemoveAds"), object: nil)
    }
    
    static func restorePurchases() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "restorePurchases"), object: nil)
    }
    
    //MARK: - Notifications
    
    static func changeNotificationState() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "changeNotificationState"), object: nil)
    }
}

private func sp_didUserInfoFailed(string: String) {
    print("Get Info Success")
}
