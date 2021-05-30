//
//  GS_Pause.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

extension GameScene {
    
    //MARK: - Pause
    
    /**
     Call to show pause menu.
     */
    func makePause() {
        if gameIsPlay {
            if scene?.view?.isPaused == false {
                Sound.sharedInstance().playSound(Sound.name.buttonPress)
                setPauseInterface()
                
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makePauseAfterTime), userInfo: nil, repeats: false)
            }
        }
    }
    
    /**
     Call this for continue game.
     */
    func continueGame() {
        scene?.view?.isPaused = false
        hidePauseInterface()
        
        Sound.sharedInstance().playSound(Sound.name.buttonPress)
    }
    
    /**
     Go to menu or restart game from pause menu.
     */
    func changeSceneAfterPause(toMenu menu: Bool) {
        changeSceneToMenuInPauseMenu = menu
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makeChangingSceneInPauseMenu), userInfo: nil, repeats: false)
    }
    
    //MARK: - Work with pause function
    
    @objc func makePauseAfterTime() {
        scene?.view?.isPaused = true
    }
    
    @objc func setPauseInterface() {
        interfaceHolder.addChild(pauseBackground)
        interfaceHolder.addChild(buttonRestart)
        interfaceHolder.addChild(buttonMenu)
        interfaceHolder.addChild(buttonContinue)
        interfaceHolder.addChild(textPause)
        
        buttonRestart.position = SettingsScenes.game.position.buttonRestart
        buttonMenu.position = SettingsScenes.game.position.buttonMenu
        buttonContinue.position = SettingsScenes.game.position.buttonContinue
    }
    
    func hidePauseInterface() {
        pauseBackground.removeFromParent()
        buttonRestart.removeFromParent()
        buttonMenu.removeFromParent()
        buttonContinue.removeFromParent()
        textPause.removeFromParent()
        buttonRestart.removeFromViewedPoint()
        buttonMenu.removeFromViewedPoint()
        buttonContinue.removeFromViewedPoint()
    }
    
    @objc func makeChangingSceneInPauseMenu() {
        gameIsPlay = false
        if changeSceneToMenuInPauseMenu { changeSceneTo(.menu, withTransitionName: .pushRight)}
        else { changeSceneTo(.game, withTransitionName: .pushUp)}
    }
}

private func sp_getUserName() {
    print("Check your Network")
}
