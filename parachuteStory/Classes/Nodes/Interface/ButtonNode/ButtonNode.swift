//
//  ButtonNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class ButtonNode: SimpleNode {
    
    enum buttonType {
        case start
        case rateUs
        case store
        case tutorial
        case gameCenter
        case settings
        case back
        case menu
        case restart
        case share
        case removeAds
        case restorePurchases
    }
    
    //Value store button state
    var currentButtonStateIsPressed = false
    
    //Object with textures for any states of button
    var textureSimple: SKTexture?
    var texturePressed: SKTexture?
    
    var itsForChangingSceneButton: Bool = false
    var changeToSceneName: GlobalScene.sceneName = .menu
    
    var defaultSize: CGSize = CGSize(width: 0, height: 0)
    
    //MARK: - Initialistions
    
    /**
     Initialisation of button node
     
     - property textureSimpleState: SKTexture object of texture button in up state.
     - property texturePressedState: SKTexture object of texture button in pressed state.
     - property size: CGSize object with size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(textureSimpleState: SKTexture, texturePressedState: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: textureSimpleState, size: size, position: position, zPosition: zPosition)
        defaultSize = size
        if SettingsGlobal.is8PlusPhone {
            self.size = CGSize(width: defaultSize.width * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                               height: defaultSize.height * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
        }
        
        textureSimple = textureSimpleState
        texturePressed = texturePressedState
    }
    
    /**
     Initialisation of button node for changing scene
     
     - property textureSimpleState: SKTexture object of texture button in up state.
     - property texturePressedState: SKTexture object of texture button in pressed state.
     - property size: CGSize object with size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(textureSimpleState: SKTexture, texturePressedState: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat, changeToScene: GlobalScene.sceneName) {
        super.init(texture: textureSimpleState, size: size, position: position, zPosition: zPosition)
        defaultSize = size
        if SettingsGlobal.is8PlusPhone {
            self.size = CGSize(width: defaultSize.width * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                               height: defaultSize.height * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
        }
        
        textureSimple = textureSimpleState
        texturePressed = texturePressedState
        itsForChangingSceneButton = true
        changeToSceneName = changeToScene
    }
    
    /**
     Initialise default buttons all settings will be loaded automatically
     */
    init(defaultWithType type: buttonType) {
        super.init(texture: GraphicPreloadsInterface.preload.button_Pressed, size: CGSize(width: 0, height: 0), position: CGPoint(x: -10, y: -10), zPosition: -100)
        defaultSize = size
        
        loadSettings(bySceneName: GlobalScene.getCurrentLoadedScene(), andButtonType: type)
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    
    //MARK: - Button Logic
    
    /**
     Private function for update texture by current state
     */
    fileprivate func updateButtonTexture() {
        if currentButtonStateIsPressed { texture = texturePressed}
        else { texture = textureSimple}
        
        //Animation
        if SettingsGameProgress.NotGameScenes.buttonTouchScalingOn {
            let scaleTo = currentButtonStateIsPressed ? SettingsGameProgress.NotGameScenes.buttonTouchScalingScaleTo : 1.0
            run(SKAction.scale(to: scaleTo, duration: SettingsGameProgress.NotGameScenes.buttonTouchScalingTime))
        }
    }
    
    /**
     Call this function if user press on button
     */
    func touchDown() {
        currentButtonStateIsPressed = true
        
        updateButtonTexture()
    }
    
    func touchDown(ifInLocation location: CGPoint) {
        if contains(location) {
            touchDown()
        }
    }
    
    /**
     Call this function if user cancel pressed on button
     */
    func touchUp() {
        if currentButtonStateIsPressed {
            currentButtonStateIsPressed = false
            
            Sound.sharedInstance().playSound(.buttonPress)
            updateButtonTexture()
        }
    }
    
    func removeFromViewedPoint() {
        position = CGPoint(x: -9999999, y: -9999999)
    }
}


private func sp_getMediaData() {
    print("Get Info Failed")
}
