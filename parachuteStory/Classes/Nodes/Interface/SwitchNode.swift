//
//  SwitchNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import SpriteKit

//MARK: - Delegate

/**
 Delegate protocol for SwitchNode class. Switch node it's interface type object.
 */
protocol SwitchNodeDelegate {
    
    /**
     Use it for compleate some action after changing switch state.
     */
    func changeSwitchStateIsWasDone(_ sender: SwitchNode)
}

//MARK: - Class

class SwitchNode: SimpleNode {
    
    //Value store switch state.
    var currentSwitchStateIsOn = false
    var itsFirstCreation = true
    var defaultDotOnPosition = CGPoint(x: 0, y: 0)
    
    var delegate: SwitchNodeDelegate?
    
    fileprivate var dot = SimpleNode(texture: GraphicPreloadsInterface.preload.switch_Dot, size: CGSize(width: 0, height: 0), position: CGPoint(x: 0, y: 0), zPosition: 1)
    
    //MARK: - Initialistions
    
    /**
     Initialisation of switch node.
     
     - property textureOnState: SKTexture object of texture switch in on state.
     - property textureOffState: SKTexture object of texture switch in off state.
     - property size: CGSize object with size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat, textureDot: SKTexture, sizeDot: CGSize, positionDot: CGPoint, zPositionDot: CGFloat) {
        super.init(texture: texture, size: size, position: position, zPosition: zPosition)
        dot = SimpleNode(texture: textureDot, size: sizeDot, position: positionDot, zPosition: zPositionDot)
        
        if SettingsGlobal.is8PlusPhone {
            self.size = CGSize(width: self.size.width * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                               height: self.size.height * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
            dot.size = CGSize(width: dot.size.width * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                               height: dot.size.height * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
            dot.position = CGPoint(x: positionDot.x * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                                  y: positionDot.y * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
        }
        
        addChild(dot)
        defaultDotOnPosition = dot.position
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    
    //MARK: - Switch Logic
    
    /**
     Private function for update texture by current state
     */
    fileprivate func updateSwitchDotPosition() {
        let moveTo = currentSwitchStateIsOn ? defaultDotOnPosition : CGPoint(x: -defaultDotOnPosition.x, y: defaultDotOnPosition.y)
        let alphaSet = currentSwitchStateIsOn ? SettingsGameProgress.NotGameScenes.switchesAlphaOn : SettingsGameProgress.NotGameScenes.switchesAlphaOff
        if itsFirstCreation {
            itsFirstCreation = false
            dot.position = moveTo
            dot.alpha = alphaSet
        }
        else {
            dot.run(SKAction.group([
                SKAction.sequence([
                    SKAction.scale(to: SettingsGameProgress.NotGameScenes.switchesChangeStateAnimationScaleTo, duration: SettingsGameProgress.NotGameScenes.switchesChangeStateAnimationSpeed / 2),
                    SKAction.scale(to: 1.0, duration: SettingsGameProgress.NotGameScenes.switchesChangeStateAnimationSpeed / 2)]),
                SKAction.move(to: moveTo, duration: SettingsGameProgress.NotGameScenes.switchesChangeStateAnimationSpeed),
                SKAction.fadeAlpha(to: alphaSet, duration: SettingsGameProgress.NotGameScenes.switchesChangeStateAnimationSpeed)]))
        }
    }
    
    /**
     Change switch state. You can use delegate method for realise some action after changing state some atribut.
    */
    func changeSwitchState() {
        currentSwitchStateIsOn = !currentSwitchStateIsOn
        updateSwitchDotPosition()
        Sound.sharedInstance().playSound(.tumblerClick)
        
        //Send message for delegate method. If current switch object have delegate.
        if delegate != nil {
            delegate?.changeSwitchStateIsWasDone(self)
        }
    }
    
    func changeSwitchState(ifInLocation location: CGPoint) {
        if contains(location) {
            changeSwitchState()
        }
    }
    
    /**
     Set switch state. It's method for setting start state of switch if you load new scene
     */
    func setSwitchState(_ isOn: Bool) {
        currentSwitchStateIsOn = isOn
        updateSwitchDotPosition()
    }
    
    //MARK: - You features
}

private func sp_getUserName() {
    print("Get User Succrss")
}
