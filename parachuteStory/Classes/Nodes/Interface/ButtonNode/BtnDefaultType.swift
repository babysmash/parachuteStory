//
//  BtnDefaultType.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import UIKit
import Foundation

extension ButtonNode {
    
    /*
     This is func use for default button initialisator
     It's load settings
     */
    func loadSettings(bySceneName sceneName: GlobalScene.sceneName, andButtonType type: buttonType) {
        switch sceneName {
        case .menu:
            switch type {
            case .start:
                textureSimple = GraphicPreloadsInterface.preload.button_Start
                texturePressed = GraphicPreloadsInterface.preload.button_StartPressed
                size = SettingsScenes.menu.size.buttonStart
                position = SettingsScenes.menu.position.buttonStart
                zPosition = SettingsScenes.menu.zPosition.buttonStart
                itsForChangingSceneButton = true
                changeToSceneName = .game
            case .rateUs:
                textureSimple = GraphicPreloadsInterface.preload.button_RateUs
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.menu.size.buttonRateUs
                position = SettingsScenes.menu.position.buttonRateUs
                zPosition = SettingsScenes.menu.zPosition.buttonRateUs
            case .store:
                textureSimple = GraphicPreloadsInterface.preload.button_Store
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.menu.size.buttonStore
                position = SettingsScenes.menu.position.buttonStore
                zPosition = SettingsScenes.menu.zPosition.buttonStore
                itsForChangingSceneButton = true
                changeToSceneName = .store
            case .tutorial:
                textureSimple = GraphicPreloadsInterface.preload.button_Tutorial
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.menu.size.buttonTutorial
                position = SettingsScenes.menu.position.buttonTutorial
                zPosition = SettingsScenes.menu.zPosition.buttonTutorial
                itsForChangingSceneButton = true
                changeToSceneName = .tutorial
            case .gameCenter:
                textureSimple = GraphicPreloadsInterface.preload.button_GameCenter
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.menu.size.buttonGameCenter
                position = SettingsScenes.menu.position.buttonGameCenter
                zPosition = SettingsScenes.menu.zPosition.buttonGameCenter
            case .settings:
                textureSimple = GraphicPreloadsInterface.preload.button_Settigns
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.menu.size.buttonSettings
                position = SettingsScenes.menu.position.buttonSettings
                zPosition = SettingsScenes.menu.zPosition.buttonSettings
                itsForChangingSceneButton = true
                changeToSceneName = .settings
            default:
                Debugger.printNow("ButtonNode: Not find default button for this scene and type")
            }
        case .settings:
            switch type {
            case .back:
                textureSimple = GraphicPreloadsInterface.preload.button_Back
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.settings.size.buttonBack
                position = SettingsScenes.settings.position.buttonBack
                zPosition = SettingsScenes.settings.zPosition.buttonBack
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            default:
                Debugger.printNow("ButtonNode: Not find default button for this scene and type")
            }
        case .end:
            switch type {
            case .menu:
                textureSimple = GraphicPreloadsInterface.preload.button_Menu
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.end.size.buttonMenu
                position = SettingsScenes.end.position.buttonMenu
                zPosition = SettingsScenes.end.zPosition.buttonMenu
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            case .restart:
                textureSimple = GraphicPreloadsInterface.preload.button_Restart
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.end.size.buttonRestart
                position = SettingsScenes.end.position.buttonRestart
                zPosition = SettingsScenes.end.zPosition.buttonRestart
                itsForChangingSceneButton = true
                changeToSceneName = .game
            case .share:
                textureSimple = GraphicPreloadsInterface.preload.button_Share
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.end.size.buttonShare
                position = SettingsScenes.end.position.buttonShare
                zPosition = SettingsScenes.end.zPosition.buttonShare
            case .gameCenter:
                textureSimple = GraphicPreloadsInterface.preload.button_GameCenter
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.end.size.buttonGameCenter
                position = SettingsScenes.end.position.buttonGameCenter
                zPosition = SettingsScenes.end.zPosition.buttonGameCenter
            default:
                Debugger.printNow("ButtonNode: Not find default button for this scene and type")
            }
        case .store:
            switch type {
            case .back:
                textureSimple = GraphicPreloadsInterface.preload.button_Back
                texturePressed = GraphicPreloadsInterface.preload.button_Pressed
                size = SettingsScenes.store.size.buttonBack
                position = SettingsScenes.store.position.buttonBack
                zPosition = SettingsScenes.store.zPosition.buttonBack
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            case .removeAds:
                textureSimple = GraphicPreloadsInterface.preload.button_RemoveAds
                texturePressed = GraphicPreloadsInterface.preload.button_InAppPressed
                size = SettingsScenes.store.size.buttonRemoveAds
                position = SettingsScenes.store.position.buttonRemoveAds
                zPosition = SettingsScenes.store.zPosition.buttonRemoveAds
            case .restorePurchases:
                textureSimple = GraphicPreloadsInterface.preload.button_RestorePurchases
                texturePressed = GraphicPreloadsInterface.preload.button_InAppPressed
                size = SettingsScenes.store.size.buttonRestorePurchases
                position = SettingsScenes.store.position.buttonRestorePurchases
                zPosition = SettingsScenes.store.zPosition.buttonRestorePurchases
            default:
                Debugger.printNow("ButtonNode: Not find default button for this scene and type")
            }
        default:
            Debugger.printNow("ButtonNode: Not find default button for this scene and type")
        }
        
        if SettingsGlobal.is8PlusPhone {
            if defaultSize.width == 0 { defaultSize = self.size}
            self.size = CGSize(width: defaultSize.width * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                               height: defaultSize.height * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
        }
        
        //Update texture
        if textureSimple != nil {
            texture = textureSimple
        }
    }
}


private func sp_checkNetWorking() {
    print("Get Info Failed")
}
