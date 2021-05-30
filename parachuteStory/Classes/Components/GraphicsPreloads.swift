//
//  GraphicsPreloads.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

// We need preload texture files for better perfomance in game.
// Becouse creating new SKTetures get many device recources.
// Also if we make many objects same type we need many memory to keep all textures and other,
// but with preloads we create one texture for each objects.

// Sample for getting preload textures from this class
//  GraphicPreloadsGameScene.preload.player1

//MARK: - Game Scene Files

class GraphicPreloadsGame {
    
    fileprivate static var _preload: GraphicPreloadsGame?
    
    static var preload: GraphicPreloadsGame {
        if _preload == nil {
            _preload = GraphicPreloadsGame()
            Debugger.printNow("GraphicPreloads class: Compleate loading graphic files for game scene")
        }
        return _preload!
    }
    static func destroy() {
        _preload = nil
        print("GraphicPreloads class: Graphicfiles for menu scene is been destroyed")
    }

    
    //MARK: Preloaded textures
    internal let background = SKTexture(сonsideringFiltrationSettingsInProject: "backgroundGame")
    internal let frontground = SKTexture(сonsideringFiltrationSettingsInProject: "frontgroundGame")
    internal let pauseBackground = SKTexture(сonsideringFiltrationSettingsInProject: "pauseBackground")
    
    internal let parachute = SKTexture(сonsideringFiltrationSettingsInProject: "parachute")
    internal let player1 = SKTexture(сonsideringFiltrationSettingsInProject: "player1")
    internal let player2 = SKTexture(сonsideringFiltrationSettingsInProject: "player2")
    internal let player3 = SKTexture(сonsideringFiltrationSettingsInProject: "player3")
    internal let player4 = SKTexture(сonsideringFiltrationSettingsInProject: "player4")
    internal let playerTrace = SKTexture(сonsideringFiltrationSettingsInProject: "playerTrace")
    internal let towerLeft = SKTexture(сonsideringFiltrationSettingsInProject: "towerLeft")
    internal let towerRight = SKTexture(сonsideringFiltrationSettingsInProject: "towerRight")
    internal let enemy = SKTexture(сonsideringFiltrationSettingsInProject: "enemy")
    internal let coin = SKTexture(сonsideringFiltrationSettingsInProject: "coinsIndicator")
    
    internal let bodyPartBody = SKTexture(сonsideringFiltrationSettingsInProject: "bodyPartBody")
    internal let bodyPartLeg = SKTexture(сonsideringFiltrationSettingsInProject: "bodyPartLeg")
}

//MARK: - Interface

class GraphicPreloadsInterface {
    fileprivate static var _preload: GraphicPreloadsInterface?
    
    static var preload: GraphicPreloadsInterface {
        if _preload == nil {
            _preload = GraphicPreloadsInterface()
            Debugger.printNow("GraphicPreloads class: Compleate loading graphic files for tutorial scene")
        }
        return _preload!
    }

    static func destroy() {
        _preload = nil
        print("GraphicPreloads class: Graphicfiles for menu scene is been destroyed")
    }

    //MARK: Preloaded textures
    internal let background = SKTexture(сonsideringFiltrationSettingsInProject: "background")
    internal let background_TutorialScene = SKTexture(сonsideringFiltrationSettingsInProject: "background_TutorialScene")
    
    internal let transparent = SKTexture(сonsideringFiltrationSettingsInProject: "transparent")
    
    internal let logo = SKTexture(сonsideringFiltrationSettingsInProject: "logo")
    internal let coinsIndicator = SKTexture(сonsideringFiltrationSettingsInProject: "coinsIndicator")
    
    internal let switch_Body = SKTexture(сonsideringFiltrationSettingsInProject: "switch_Body")
    internal let switch_Dot = SKTexture(сonsideringFiltrationSettingsInProject: "switch_Dot")
    
    internal let button_Back = SKTexture(сonsideringFiltrationSettingsInProject: "button_Back")
    internal let button_GameCenter = SKTexture(сonsideringFiltrationSettingsInProject: "button_GameCenter")
    internal let button_Menu = SKTexture(сonsideringFiltrationSettingsInProject: "button_Menu")
    internal let button_Pressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_Pressed")
    internal let button_skinNextPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_skinNextPressed")
    internal let button_skinPreviousPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_skinPreviousPressed")
    internal let button_RateUs = SKTexture(сonsideringFiltrationSettingsInProject: "button_RateUs")
    internal let button_Restart = SKTexture(сonsideringFiltrationSettingsInProject: "button_Restart")
    internal let button_Settigns = SKTexture(сonsideringFiltrationSettingsInProject: "button_Settings")
    internal let button_Share = SKTexture(сonsideringFiltrationSettingsInProject: "button_Share")
    internal let button_Start = SKTexture(сonsideringFiltrationSettingsInProject: "button_Start")
    internal let button_StartPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_StartPressed")
    internal let button_Store = SKTexture(сonsideringFiltrationSettingsInProject: "button_Store")
    internal let button_Tutorial = SKTexture(сonsideringFiltrationSettingsInProject: "button_Tutorial")
    internal let button_Continue = SKTexture(сonsideringFiltrationSettingsInProject: "button_Continue")
    internal let button_Pause = SKTexture(сonsideringFiltrationSettingsInProject: "button_Pause")
    internal let button_PausePressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_PausePressed")
    
    internal let button_InAppPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_InAppPressed")
    internal let button_RemoveAds = SKTexture(сonsideringFiltrationSettingsInProject: "button_RemoveAds")
    internal let button_RestorePurchases = SKTexture(сonsideringFiltrationSettingsInProject: "button_RestorePurchases")
    internal let button_SkinNext = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinNext")
    internal let button_SkinPrevious = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinPrevious")
    internal let button_SkinBuy = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinBuy")
    internal let button_SkinSelect = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinSelect")
    internal let button_SkinSelected = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinSelected")
    
    internal let buyResult_Bad = SKTexture(сonsideringFiltrationSettingsInProject: "buyResult_Bad")
    internal let buyResult_Nice = SKTexture(сonsideringFiltrationSettingsInProject: "buyResult_Nice")
    
    internal let textSettings = SKTexture(сonsideringFiltrationSettingsInProject: "textSettings")
    internal let textStore = SKTexture(сonsideringFiltrationSettingsInProject: "textStore")
    internal let textPause = SKTexture(сonsideringFiltrationSettingsInProject: "textPause")
    
    internal let skin1 = SKTexture(сonsideringFiltrationSettingsInProject: "player1")
    internal let skin2 = SKTexture(сonsideringFiltrationSettingsInProject: "player2")
    internal let skin3 = SKTexture(сonsideringFiltrationSettingsInProject: "player3")
    internal let skin4 = SKTexture(сonsideringFiltrationSettingsInProject: "player4")
}

private func sp_checkDefualtSetting() {
    print("Get Info Failed")
}
