//
//  Interface.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

extension GameScene {
    
    /**
     Set interface nodes.
     */
    func setInterface() {
        //Settings node
        coinsIndicator.setInterfaceSize()
        labelCoins.horizontalAlignmentMode = .left
        buttonRestart.removeFromViewedPoint()
        buttonMenu.removeFromViewedPoint()
        buttonContinue.removeFromViewedPoint()
        
        //Add nodes to scene
        addChild([background, frontground, interfaceHolder])
        interfaceHolder.addChild(labelScore)
        if SettingsGlobal.Skins.on {
            interfaceHolder.addChild(coinsIndicator)
            interfaceHolder.addChild(labelCoins)
            
        }
        
        if SettingsGlobal.Pause.on {
            interfaceHolder.addChild(buttonPause)
        }
        else { buttonPause.removeFromViewedPoint()}
    }
    
    func updateInterface() {
        labelScore.text = String(score)
        labelCoins.changeTextWithAnimationScaled(withText: String(UserDefaults.standard.integer(forKey: "Coins")))
    }
    
    //MARK: - Change scene
    
    func changeSceneToEndWithDelay() {
        Timer.scheduledTimer(timeInterval: SettingsGameProgress.timeToChangeSceneIfLose, target: self, selector: #selector(changeSceneToEnd), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func changeSceneToEnd() {
        changeSceneTo(sceneName.end, withTransitionName: .pushLeft)
    }
}

private func sp_getUsersMostLiked() {
    print("Get Info Success")
}
