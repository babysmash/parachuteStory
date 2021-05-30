//
//  SettingsScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class SettingsScene: GlobalScene, SwitchNodeDelegate {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    
    fileprivate let switchSound = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.settings.size.switchSound, position: SettingsScenes.settings.position.switchSound, zPosition: SettingsScenes.settings.zPosition.switchSound, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.settings.size.switchSoundDot, positionDot: SettingsScenes.settings.position.switchDotOn, zPositionDot: SettingsScenes.settings.zPosition.switchDot)
    fileprivate let switchMusic = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.settings.size.switchMusic, position: SettingsScenes.settings.position.switchMusic, zPosition: SettingsScenes.settings.zPosition.switchMusic, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.settings.size.switchMusicDot, positionDot: SettingsScenes.settings.position.switchDotOn, zPositionDot: SettingsScenes.settings.zPosition.switchDot)
    fileprivate let switchNotification = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.settings.size.switchNotification, position: SettingsScenes.settings.position.switchNotification, zPosition: SettingsScenes.settings.zPosition.switchNotification, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.settings.size.switchNotificationDot, positionDot: SettingsScenes.settings.position.switchDotOn, zPositionDot: SettingsScenes.settings.zPosition.switchDot)
    
    fileprivate let buttonBack = ButtonNode(defaultWithType: .back)
    
    fileprivate let labelSound = SimpleLabel(text: "Play Sounds", fontSize: SettingsScenes.settings.fontSize.labelSound, fontColorHex: SettingsScenes.settings.fontColor.labelSound, position: SettingsScenes.settings.position.labelSound, zPosition: SettingsScenes.settings.zPosition.labelSound)
    fileprivate let labelMusic = SimpleLabel(text: "Play Music", fontSize: SettingsScenes.settings.fontSize.labelMusic, fontColorHex: SettingsScenes.settings.fontColor.labelMusic, position: SettingsScenes.settings.position.labelMusic, zPosition: SettingsScenes.settings.zPosition.labelMusic)
    fileprivate let labelNotification = SimpleLabel(text: "Notifications", fontSize: SettingsScenes.settings.fontSize.labelNotification, fontColorHex: SettingsScenes.settings.fontColor.labelNotification, position: SettingsScenes.settings.position.labelNotification, zPosition: SettingsScenes.settings.zPosition.labelNotification)
    
    fileprivate let textSettings = SimpleNode(texture: GraphicPreloadsInterface.preload.textSettings, size: SettingsScenes.settings.size.textSettings, position: SettingsScenes.settings.position.textSettings, zPosition: SettingsScenes.settings.zPosition.textSettings)
    
    //MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
        //Setting node
        labelSound.horizontalAlignmentMode = .right
        labelMusic.horizontalAlignmentMode = .right
        labelNotification.horizontalAlignmentMode = .right
        
        textSettings.setInterfaceSize()
        
        switchSound.setSwitchState(UserDefaults.standard.bool(forKey: "PlaySounds"))
        switchMusic.setSwitchState(UserDefaults.standard.bool(forKey: "PlayMusic"))
        switchNotification.setSwitchState(UserDefaults.standard.bool(forKey: "NotificationOn"))
        switchSound.delegate = self
        switchMusic.delegate = self
        switchNotification.delegate = self
        
        //Add nodes to view
        addChild([background, switchSound, switchMusic, switchNotification, buttonBack, labelSound, labelMusic, labelNotification, textSettings])
    }
    
    //MARK: - Logic
    
    // This method it's delegate from SwitchNode class.
    // If you try to change state of switch system call this method.
    // Use it for change some game settings in game.
    func changeSwitchStateIsWasDone(_ sender: SwitchNode) {
        //Change state sound
        if sender == switchSound { Sound.sharedInstance().changeSoundState()}
        //Change state music
        if sender == switchMusic { Sound.sharedInstance().changeMusicState()}
        //Change state notifications
        if sender == switchNotification { ExternalFunctions.changeNotificationState()}
    }
    
    //MARK: - Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            //Check press to switch
            switchSound.changeSwitchState(ifInLocation: location)
            switchMusic.changeSwitchState(ifInLocation: location)
            switchNotification.changeSwitchState(ifInLocation: location)
            
            //Check press to button
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            //Change button state to simple
            touchUpAllButtons()
            
            buttonBack.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
        }
    }
}

private func sp_getUsersMostLikedSuccess() {
    print("Get User Succrss")
}
