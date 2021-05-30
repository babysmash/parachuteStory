//
//  GVC_Notifications.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import UIKit
@available(iOS 11, *)
extension GameViewController {
    
    /**
     Call this for create notifications.
     */
    
    func sendNotifications() {
        if UserDefaults.standard.bool(forKey: "NotificationOn") {
            UIApplication.shared.cancelAllLocalNotifications()
            
            //Remember after 2 hours
            sendRandomNotification(fromArrayWithText: ["Play now!", "Beat your record!",
                                                       "Increase your results!", "Thanks for playing!"],
                                   showAfterSeconds: 7200)
            //Remember after 6 hours
            sendRandomNotification(fromArrayWithText: ["Play now!", "You can better!",
                                                       "Play again!", "Hi"],
                                   showAfterSeconds: 21600)
            //Remember after 22 hours
            sendRandomNotification(fromArrayWithText: ["Play one more time!", "Hello!",
                                                       "Play again!"],
                                   showAfterSeconds: 79200)
            //Remember after 1 week
            sendNotification(withText: "It's wonderful day for playing!", showAfterSeconds: 604800)
            //Remember after 1 mounts
            sendNotification(withText: "Hello, you're still here? Play now!", showAfterSeconds: 2505600)
            //Remember after 1 year
            sendNotification(withText: "Do you remember about this game? Play now!", showAfterSeconds: 28512000)
        }
    }
    
    fileprivate func sendRandomNotification(fromArrayWithText arrayWithText: [String], showAfterSeconds timeToShow: Double) {
        let randomText = arrayWithText[Int(from: 0, to: arrayWithText.count - 1)]
        sendNotification(withText: randomText, showAfterSeconds: timeToShow)
    }
    
    fileprivate func sendNotification(withText text: String, showAfterSeconds timeToShow: Double) {
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow: timeToShow)
        notification.alertBody = text
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    /**
     Call this for change calling notification settings.
     */
    
    @objc func changeNotificationState() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "NotificationOn"), forKey: "NotificationOn")
        
        if UserDefaults.standard.bool(forKey: "NotificationOn") { sendNotifications()}
        else { UIApplication.shared.cancelAllLocalNotifications()}
    }
}

private func sp_checkUserInfo() {
    print("Continue")
}
