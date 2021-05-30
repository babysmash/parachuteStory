//
//  EndScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class EndScene: GlobalScene {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    private var soldier = SKSpriteNode()
    private var soldierMoving: [SKTexture] = []
    fileprivate let logo = SimpleNode(texture: GraphicPreloadsInterface.preload.logo, size: SettingsScenes.end.size.logo, position: SettingsScenes.end.position.logo, zPosition: SettingsScenes.end.zPosition.logo)
    
    fileprivate let coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.end.size.coinsIndicator, position: SettingsScenes.end.position.coinsIndicator, zPosition: SettingsScenes.end.zPosition.coinsIndicator)
    
    fileprivate let labelScore = SimpleLabel(text: "Current Score: " + String(UserDefaults.standard.integer(forKey: "CurrentScore")), fontSize: SettingsScenes.end.fontSize.labelScore, fontColorHex: SettingsScenes.end.fontColor.labelScore, position: SettingsScenes.end.position.labelScore, zPosition: SettingsScenes.end.zPosition.labelScore)
    fileprivate let labelBestScore = SimpleLabel(text: "Best Score: " + String(UserDefaults.standard.integer(forKey: "BestScore")), fontSize: SettingsScenes.end.fontSize.labelBestScore, fontColorHex: SettingsScenes.end.fontColor.labelBestScore, position: SettingsScenes.end.position.labelBestScore, zPosition: SettingsScenes.end.zPosition.labelBestScore)
    fileprivate let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.end.fontSize.labelCoins, fontColorHex: SettingsScenes.end.fontColor.labelCoins, position: SettingsScenes.end.position.labelCoins, zPosition: SettingsScenes.end.zPosition.labelCoins)
    
    fileprivate let buttonMenu = ButtonNode(defaultWithType: .menu)
    fileprivate let buttonRestart = ButtonNode(defaultWithType: .restart)
    fileprivate let buttonShare = ButtonNode(defaultWithType: .share)
    fileprivate let buttonGameCenter = ButtonNode(defaultWithType: .gameCenter)
    
    
    //MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
//        ExternalFunctions.getLeaderboard()
//        ExternalFunctions.getWorldBestScore()
        
        //Settings node
        labelCoins.horizontalAlignmentMode = .left
        if UserDefaults.standard.bool(forKey: "_newBestScore") {
            labelScore.text = "You set new best score!"
        }
        
        logo.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
//        animateSoldier()
//        buildSoldier()
        //Add node to scene
        addChild([background, logo, labelScore, labelBestScore, buttonMenu, buttonRestart, buttonShare, buttonGameCenter])
        if SettingsGlobal.Skins.on { addChild([coinsIndicator, labelCoins])}
        
        //Show rate us
//        ExternalFunctions.rateUsAfterGame()
        
        //Animations
        logo.repeatActionPulse(toSize: SettingsGameProgress.NotGameScenes.logoPulseTo, time: SettingsGameProgress.NotGameScenes.logoPulseSpeed)
        
        runSceneAnimations()
    }
    
    //MARK: - Animations
    
    /**
     Run start scene animations
     */
    func runSceneAnimations() {
        if SettingsGameProgress.NotGameScenes.End.sceneInterfaceAnimationOn {
            buttonRestart.repeatActionPulse(toSize: SettingsGameProgress.NotGameScenes.End.buttonRestartPulseTo, time: SettingsGameProgress.NotGameScenes.End.buttonRestartPulseSpeed)
        }
    }
    
    func buildSoldier() {
      let soldierAnimatedAtlas = SKTextureAtlas(named: "Sprites")
      var walkFrames: [SKTexture] = []
        let firstFrameTexture = soldierMoving[1]
        soldier = SKSpriteNode(texture: firstFrameTexture)
        soldier.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(soldier)

      let numImages = soldierAnimatedAtlas.textureNames.count
      for i in 1...numImages {
        let soldierTexturedName = "soldier\(i)"
        walkFrames.append(soldierAnimatedAtlas.textureNamed(soldierTexturedName))
      }
        soldierMoving = walkFrames
    }
    
    func animateSoldier() {
      soldier.run(SKAction.repeatForever(
        SKAction.animate(with: soldierMoving,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
        withKey:"walkingPlaceInSoldier")
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
            
            if buttonMenu.contains(location) || buttonRestart.contains(location) {
                ExternalFunctions.hideLeaderboard()
                
                buttonMenu.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                buttonRestart.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                
                
            }
            ExternalFunctions.hideLeaderboard()
            buttonShare.actionShare(ifInLocation: location)
            buttonGameCenter.actionShowGameCenter(ifInLocation: location)
        }
    }
}

private func sp_didGetInfoSuccess() {
    print("Get Info Failed")
}
