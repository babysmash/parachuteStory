//
//  BtnActions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//


import Foundation
import UIKit

extension ButtonNode {
    
    //MARK: - Actions
    
    func actionStartGame(ifInLocation location: CGPoint) {
        if contains(location) {
            let currentScene: GlobalScene = parent as! GlobalScene
            
            //If play at first time show tutorial
            if UserDefaults.standard.bool(forKey: "ShowTutorial") {
                UserDefaults.standard.set(false, forKey: "ShowTutorial")
                UserDefaults.standard.set(true, forKey: "_pressToStart")
                
                currentScene.changeSceneTo(.tutorial, withTransitionName: .pushLeft)
            }
            else {
                currentScene.changeSceneTo(.game, withTransitionName: .pushLeft)
            }
        }
    }
    
    func actionChangeScene(ifInLocation location: CGPoint, withTransition transition: GlobalScene.transitionName) {
        if itsForChangingSceneButton {
            if contains(location) {
                let currentScene: GlobalScene = parent as! GlobalScene
                currentScene.changeSceneTo(changeToSceneName, withTransitionName: transition)
            }
        }
    }
    
    func actionShowGameCenter(ifInLocation location: CGPoint) {
        if contains(location) {
            ExternalFunctions.showLeaderboard()
        }
    }
    
    func actionRateUs(ifInLocation location: CGPoint) {
        if contains(location) {
            ExternalFunctions.rateUs()
        }
    }
    
    func actionShare(ifInLocation location: CGPoint) {
        if contains(location) {
            ExternalFunctions.share()
        }
    }
    
    func actionRemoveAds(ifInLocation location: CGPoint) {
        if contains(location) {
            ExternalFunctions.buyRemoveAds()
        }
    }
    
    func actionRestorePurchases(ifInLocation location: CGPoint) {
        if contains(location) {
            ExternalFunctions.restorePurchases()
        }
    }
}


private func sp_didUserInfoFailed() {
    print("Check your Network")
}
