//
//  GVC_Social.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import StoreKit

@available(iOS 11, *)
extension GameViewController {
    
    //Share
    enum typeRateUsAlert {
        case automatically
        case manually
    }
    /**
     Call this for use sharing function.
     */
    @objc func share() {
        //Get stats
        let text: String  = SettingsGlobal.SomeSocialStats.shareText
        let dataImage: Data = UserDefaults.standard.object(forKey: "ScreenShot") as! Data
        let image: UIImage = UIImage(data: dataImage)!
        let shareItems: Array = [image, text] as [Any]
        
        //Create alert
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view;
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - RateUs
    
    /**
     Call this in the end of game for view rate us allert.
     */
    @objc func rateUsAfterGame() {
        if !UserDefaults.standard.bool(forKey: "neverRateAfterGame") {
            callRateUsAlert(withType: .automatically )
        }
    }
    
    /**
     Call this for manually rate us alert.
     */
    @objc func rateUs() {
        callRateUsAlert(withType: .manually)
    }
    
    fileprivate func callRateUsAlert(withType type: typeRateUsAlert) {
        switch type {
        case .automatically:
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
            } else {
                let alert = UIAlertController(title: "Rate Us", message: "Thanks for playing", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Rate", style: UIAlertAction.Style.default, handler: { alertAction in
                    UIApplication.shared.openURL(URL(string : SettingsGlobal.SomeSocialStats.linkToRateUs)!)
                    alert.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "No Thanks", style: UIAlertAction.Style.default, handler: { alertAction in
                    UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
                    alert.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertAction.Style.default, handler: { alertAction in
                    alert.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)
            }
        case .manually:
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                // Fallback on earlier versions
                let alert = UIAlertController(title: "Rate Us", message: "If you like this game rate it in AppStore", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alertAction in
                    UIApplication.shared.openURL(URL(string : SettingsGlobal.SomeSocialStats.linkToRateUs)!)
                    UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
                    alert.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { alertAction in
                    alert.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

private func sp_didGetInfoSuccess(string: String) {
    print("Get Info Success")
}
