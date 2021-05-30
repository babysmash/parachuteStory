//
//  MenuScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class MenuScene: GlobalScene {
    
    //MARK: Nodes
    var worldBestScoreAlreadyShowed = false
    
    fileprivate let background = BackgroundNode()
    fileprivate let logo = SimpleNode(texture: GraphicPreloadsInterface.preload.logo, size: SettingsScenes.menu.size.logo, position: SettingsScenes.menu.position.logo, zPosition: SettingsScenes.menu.zPosition.logo)
    
    fileprivate let coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.menu.size.coinsIndicator, position: SettingsScenes.menu.position.coinsIndicator, zPosition: SettingsScenes.menu.zPosition.coinsIndicator)
    
    fileprivate let buttonStart = ButtonNode(defaultWithType: .start)
    fileprivate let buttonStore = ButtonNode(defaultWithType: .store)
    fileprivate let buttonRateUs = ButtonNode(defaultWithType: .rateUs)
    fileprivate let buttonTutorial = ButtonNode(defaultWithType: .tutorial)
    fileprivate let buttonGameCenter = ButtonNode(defaultWithType: .gameCenter)
    fileprivate let buttonSettings = ButtonNode(defaultWithType: .settings)
    
    fileprivate let labelBestScore = SimpleLabel(text: "Your Best Score: " + String(UserDefaults.standard.integer(forKey: "BestScore")), fontSize: SettingsScenes.menu.fontSize.labelBestScore, fontColorHex: SettingsScenes.menu.fontColor.labelBestScore, position: SettingsScenes.menu.position.labelBestScore, zPosition: SettingsScenes.menu.zPosition.labelBestScore)
    fileprivate let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.menu.fontSize.labelCoins, fontColorHex: SettingsScenes.menu.fontColor.labelCoins, position: SettingsScenes.menu.position.labelCoins, zPosition: SettingsScenes.menu.zPosition.labelCoins)
    fileprivate let labelWorldBestScoreName = SimpleLabel(text: "", fontSize: SettingsScenes.menu.fontSize.labelWorldBestScoreName, fontColorHex: SettingsScenes.menu.fontColor.labelWorldBestScoreName, position: SettingsScenes.menu.position.labelWorldBestScoreName, zPosition: SettingsScenes.menu.zPosition.labelWorldBestScoreName)
    fileprivate let labelWorldBestScoreValue = SimpleLabel(text: "", fontSize: SettingsScenes.menu.fontSize.labelWorldBestScoreValue, fontColorHex: SettingsScenes.menu.fontColor.labelWorldBestScoreValue, position: SettingsScenes.menu.position.labelWorldBestScoreValue, zPosition: SettingsScenes.menu.zPosition.labelWorldBestScoreValue)
    
    //MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
        //Settings node
        labelCoins.horizontalAlignmentMode = .left
        labelBestScore.horizontalAlignmentMode = .left
        labelWorldBestScoreName.horizontalAlignmentMode = .right
        labelWorldBestScoreValue.horizontalAlignmentMode = .right
        
        logo.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        //Add nodes to scene
        addChild([background, logo, buttonStart, buttonRateUs, buttonTutorial, buttonGameCenter, buttonSettings, labelBestScore, labelWorldBestScoreName, labelWorldBestScoreValue])
        if SettingsGlobal.InApp.on || SettingsGlobal.Skins.on {
            addChild(buttonStore)
            
            if SettingsGlobal.Skins.on {
                addChild([coinsIndicator, labelCoins])
            }
        }
        else { buttonStore.removeFromViewedPoint()}
        
        //Animations
        logo.repeatActionPulse(toSize: SettingsGameProgress.NotGameScenes.logoPulseTo, time: SettingsGameProgress.NotGameScenes.logoPulseSpeed)
        
        runSceneAnimations()
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Try to show world best score
        updateLabelWorldBestScore()
    }
    
    /**
     Try to load world best score
     */
    fileprivate func updateLabelWorldBestScore() {
        if !worldBestScoreAlreadyShowed {
            let animationShow = SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: 0),
                SKAction.fadeAlpha(to: 1, duration: SettingsGameProgress.NotGameScenes.Menu.labelsWorldBestScoreAnimationShowSpeed)])
            
            if SettingsGlobal.GameCenter.testMode {
                labelWorldBestScoreValue.run(animationShow)
                labelWorldBestScoreName.run(animationShow)
                labelWorldBestScoreValue.text = "World Best Score: 326"
                labelWorldBestScoreName.text = "Top Player: Nano"
                
                worldBestScoreAlreadyShowed = true
            }
            else {
                if !worldBestScoreAlreadyShowed {
                    if UserDefaults.standard.bool(forKey: "GC_worldBestScore_PossibleToShow") {
                        labelWorldBestScoreValue.run(animationShow)
                        labelWorldBestScoreName.run(animationShow)
                        labelWorldBestScoreValue.text = "World Best Score: " + UserDefaults.standard.string(forKey: "GC_worldBestScore_Value_leaderboard")!
                        labelWorldBestScoreName.text = "From Player: " + UserDefaults.standard.string(forKey: "GC_worldBestScore_Name_leaderboard")!
                        
                        worldBestScoreAlreadyShowed = true
                    } else {
                        ExternalFunctions.getWorldBestScore()
                    }
                }
            }
        }
    }
    
    
    //MARK: - Scene animations
    
    /**
     Run start scene animations
     */
    func runSceneAnimations() {
        if SettingsGameProgress.NotGameScenes.Menu.sceneInterfaceAnimationOn {
            let buttonStartDefaultPosition = buttonStart.position
            buttonStart.position = CGPoint(x: -100, y: buttonStart.position.y)
            let buttonStartAnimation = SKAction.sequence([
                SKAction.scale(to: SettingsGameProgress.NotGameScenes.Menu.startButtonScaleStart, duration: 0),
                SKAction.group([
                    SKAction.rotateByDegree(-360, duration: SettingsGameProgress.NotGameScenes.Menu.startButtonRotationSpeed),
                    SKAction.moveTo(x: buttonStartDefaultPosition.x, duration: SettingsGameProgress.NotGameScenes.Menu.startButtonRotationSpeed)]),
                SKAction.scale(to: 1.0, duration: SettingsGameProgress.NotGameScenes.Menu.startButtonScaleBackToNormalTime)])
            let otherButtonAnimation = SKAction.sequence([
                SKAction.wait(forDuration: SettingsGameProgress.NotGameScenes.Menu.startButtonRotationSpeed),
                SKAction.scale(to: SettingsGameProgress.NotGameScenes.Menu.buttonsScaleTo, duration: SettingsGameProgress.NotGameScenes.Menu.buttonsScaleTime / 2),
                SKAction.scale(to: 1.0, duration: SettingsGameProgress.NotGameScenes.Menu.buttonsScaleTime / 2)])
            
            buttonStart.run(buttonStartAnimation)
            buttonRateUs.run(otherButtonAnimation)
            buttonTutorial.run(otherButtonAnimation)
            buttonGameCenter.run(otherButtonAnimation)
            buttonSettings.run(otherButtonAnimation)
            buttonStore.run(otherButtonAnimation)
        }
    }
    
    //MARK: - Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            //Change button state to simple
            touchUpAllButtons()
            
            buttonStart.actionStartGame(ifInLocation: location)
            buttonRateUs.actionRateUs(ifInLocation: location)
            buttonStore.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
            buttonTutorial.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
            buttonGameCenter.actionShowGameCenter(ifInLocation: location)
            buttonSettings.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
        }
    }
}

private func sp_getLoginState() {
    print("Check your Network")
}
