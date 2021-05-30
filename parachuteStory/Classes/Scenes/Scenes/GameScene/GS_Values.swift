//
//  GS_Values.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import Foundation

extension GameScene {
    
    //MARK: - Score
    
    /**
     Use this finction for increese score by value.
     
     - property value: Int value for add to you score.
     */
    func increaseScoreBy(_ value: Int) {
        if gameIsPlay {
            score += value
            labelScore.changeTextWithAnimationScaled(withText: score)
            
            Sound.sharedInstance().playSound(.getPoint)
        }
    }
    
    /**
     Save you current score in NSUserDefaults by key "CurrentScore", "BestScore" and if you set new best score you can check in by bool value with key "_newBestScore".
     */
    func saveScore() {
        UserDefaults.standard.set(score, forKey: "CurrentScore")
        if score > UserDefaults.standard.integer(forKey: "BestScore") {
            UserDefaults.standard.set(score, forKey: "BestScore")
            UserDefaults.standard.set(true, forKey: "_newBestScore")
        }
        else {
            UserDefaults.standard.set(false, forKey: "_newBestScore")
        }
        
        ExternalFunctions.submitScore()
    }
    
    //MARK: - Coins
    func increaseCoinByOne() {
        increaseCoinsBy(1)
    }
    /**
     Use this finction for increese coins by value.
     
     
     
     - property value: Int value for add to you coins.
     */
    func increaseCoinsBy(_ value: Int) {
        if gameIsPlay {
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Coins") + value, forKey: "Coins")
            labelCoins.changeTextWithAnimationScaled(withText: String(UserDefaults.standard.integer(forKey: "Coins")))
            
            Sound.sharedInstance().playSound(.getCoin)
        }
    }
    
    //MARK: - Game speed
    
    /**
     Use to make game more faster and harder.
     */
    func increaseGameSpeeds() {
        if gameIsPlay {
            if playerSpeed > SettingsGameProgress.player.speedMax {
                playerSpeed -= (playerSpeed / 100) * SettingsGameProgress.player.speedChangeByPercent
            }
        }
    }
}

private func sp_getUsersMostFollowerSuccess() {
    print("Get User Succrss")
}
