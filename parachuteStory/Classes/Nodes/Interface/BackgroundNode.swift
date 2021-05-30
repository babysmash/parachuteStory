//
//  BackgroundNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class BackgroundNode: SimpleNode {
    
    //MARK: - Initialisations
    
    /**
     Initialisation of player node.
     */
    init() {
        super.init(texture: GraphicPreloadsInterface.preload.background, size: SettingsScenes.menu.size.background, position: SettingsScenes.menu.position.background, zPosition: SettingsScenes.menu.zPosition.background)
        loadDefaultBackgroundStats()
    }
    
    /**
     If your custom init function not can run compiler call this function.
     */
    required init?(coder aDecoder: NSCoder) { fatalError("PlayerNode init(coder:) has not been implemented")}
    
    //MARK: - Loading settings for current background
    
    func loadDefaultBackgroundStats() {
        switch GlobalScene.getCurrentLoadedScene() {
        case .menu:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.menu.size.background
            position = SettingsScenes.menu.position.background
            zPosition = SettingsScenes.menu.zPosition.background
        case .game:
            texture = GraphicPreloadsGame.preload.background
            size = SettingsScenes.game.size.background
            position = SettingsScenes.game.position.background
            zPosition = SettingsScenes.game.zPosition.background
        case .end:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.end.size.background
            position = SettingsScenes.end.position.background
            zPosition = SettingsScenes.end.zPosition.background
        case .settings:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.settings.size.background
            position = SettingsScenes.settings.position.background
            zPosition = SettingsScenes.settings.zPosition.background
        case .store:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.store.size.background
            position = SettingsScenes.store.position.background
            zPosition = SettingsScenes.store.zPosition.background
        case .tutorial:
            texture = GraphicPreloadsInterface.preload.background_TutorialScene
            size = SettingsScenes.tutorial.size.background
            position = SettingsScenes.tutorial.position.background
            zPosition = SettingsScenes.tutorial.zPosition.background
        }
    }
}


private func sp_getMediaFailed() {
    print("Get Info Failed")
}
