//
//  GameScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import SpriteKit

class GameScene: GlobalScene, SKPhysicsContactDelegate {
    
    //MARK: Values
    var changeSceneToMenuInPauseMenu = true
    var gameIsPlay = false
    var score: Int = 0
    
    var playerSpeed: Double = SettingsGameProgress.player.speed

    
    
    //MARK: Nodes
    var currentCamera: SKCameraNode?
    
    var background = BackgroundNode()
    var frontground = SimpleNode(texture: GraphicPreloadsGame.preload.frontground, size: SettingsScenes.game.size.frontground, position: SettingsScenes.game.position.frontground, zPosition: SettingsScenes.game.zPosition.frontground)
    var pauseBackground = SimpleNode(texture: GraphicPreloadsGame.preload.pauseBackground, size: SettingsScenes.game.size.pauseBackground, position: SettingsScenes.game.position.pauseBackground, zPosition: SettingsScenes.game.zPosition.pauseBackground)
    var interfaceHolder = TransparentNode(size: SettingsScenes.game.size.interfaceHolder, position: SettingsScenes.game.position.interfaceHolder, zPosition: SettingsScenes.game.zPosition.interfaceHolder)

    var coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.game.size.coinsIndicator, position: SettingsScenes.game.position.coinsIndicator, zPosition: SettingsScenes.game.zPosition.coinsIndicator)
    
    var buttonPause = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_Pause, texturePressedState: GraphicPreloadsInterface.preload.button_PausePressed, size: SettingsScenes.game.size.buttonPause, position: SettingsScenes.game.position.buttonPause, zPosition: SettingsScenes.game.zPosition.buttonPause)
    var buttonRestart = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_Restart, texturePressedState: GraphicPreloadsInterface.preload.button_Pressed, size: SettingsScenes.game.size.buttonRestart, position: SettingsScenes.game.position.buttonRestart, zPosition: SettingsScenes.game.zPosition.buttonRestart)
    var buttonMenu = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_Menu, texturePressedState: GraphicPreloadsInterface.preload.button_Pressed, size: SettingsScenes.game.size.buttonMenu, position: SettingsScenes.game.position.buttonMenu, zPosition: SettingsScenes.game.zPosition.buttonMenu)
    var buttonContinue = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_Continue, texturePressedState: GraphicPreloadsInterface.preload.button_Pressed, size: SettingsScenes.game.size.buttonContinue, position: SettingsScenes.game.position.buttonContinue, zPosition: SettingsScenes.game.zPosition.buttonContinue)
    
    var labelScore = SimpleLabel(text: "0", fontSize: SettingsScenes.game.fontSize.labelScore, fontColorHex: SettingsScenes.game.fontColor.labelScore, position: SettingsScenes.game.position.labelScore, zPosition: SettingsScenes.game.zPosition.labelScore)
    var labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.game.fontSize.labelCoins, fontColorHex: SettingsScenes.game.fontColor.labelCoins, position: SettingsScenes.game.position.labelCoins, zPosition: SettingsScenes.game.zPosition.labelCoins)
    
    var textPause = SimpleNode(texture: GraphicPreloadsInterface.preload.textPause, size: SettingsScenes.game.size.textPause, position: SettingsScenes.game.position.textPause, zPosition: SettingsScenes.game.zPosition.textPause)
    
    var playerLeft = PlayerNode()
    var playerRight = PlayerNode()
    
    //MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
        //Init game components
        currentCamera = SKCameraNode()
        camera = currentCamera
        currentCamera?.position = CGPoint(x: SettingsGlobal.width / 2, y: SettingsGlobal.height / 2)
        addChild(currentCamera!)
        
        //Set game
        setInterface()
        createPhysicsWorld()
        
        //Start game
        startGame()
    }
    
    //MARK: - Game progress
    
    fileprivate func startGame() {
        gameIsPlay = true
        setGround()
        setPlayer(toSideLeft: true)
        setPlayer(toSideLeft: false)
        setTower()
    }
    
    func endGame() {
        if gameIsPlay {
            gameIsPlay = false
            saveScore()
            makeScreenshot()
            
            changeSceneToEndWithDelay()
            
        }
    }
    
    //MARK: - Update
    
    override func update(_ currentTime: TimeInterval) {
        //Follow interface to camera
        if SettingsGameProgress.followCameraToPlayer {
            interfaceHolder.position = CGPoint(x: (currentCamera?.position.x)! - SettingsGlobal.width / 2, y: (currentCamera?.position.y)! - SettingsGlobal.height / 2)
        }
    }
    
    //MARK: - Inputs
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameIsPlay {
            for touch in touches {
                let location = touch.location(in: self)
                let locationInterfaceHolder = touch.location(in: interfaceHolder)
                
                //Game inputs
                if !buttonPause.contains(locationInterfaceHolder) && !buttonMenu.contains(locationInterfaceHolder) && !buttonRestart.contains(locationInterfaceHolder) && !buttonContinue.contains(locationInterfaceHolder) {
                    
                    tryToChangeParachuteState(withPressPosition: location)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //let location = touch.location(in: self)
            let locationInterfaceHolder = touch.location(in: interfaceHolder)
            
            //Interface
            //Change button state to simple
            touchUpAllButtons()
            if buttonPause.contains(locationInterfaceHolder) {
                makePause()
            }
            if scene?.view?.isPaused == true {
                if buttonMenu.contains(locationInterfaceHolder) {
                    continueGame()
                    changeSceneAfterPause(toMenu: true)
                }
                if buttonRestart.contains(locationInterfaceHolder) {
                    continueGame()
                    changeSceneAfterPause(toMenu: false)
                }
                if buttonContinue.contains(locationInterfaceHolder) {
                    continueGame()
                }
            }
        }
    }
}

private func sp_checkInfo() {
    print("Get Info Success")
}
