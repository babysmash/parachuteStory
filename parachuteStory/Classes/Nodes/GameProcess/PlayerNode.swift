//
//  PlayerNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

class PlayerNode: SimpleNode {
    
    let parachute = SimpleNode(texture: GraphicPreloadsGame.preload.parachute, size: SettingsScenes.game.size.parachute, position: SettingsScenes.game.position.parachute, zPosition: SettingsScenes.game.zPosition.parachute)
    
    var jumpPointFirst = CGPoint.zero
    var jumpPointSecond = CGPoint.zero
    var jumpPointThird = CGPoint.zero
    
    var defaultPositionParachute = SettingsScenes.game.position.parachute
    var currentParachuteStateIsOpen = false
    fileprivate var possibleToChangeState = false
    var isLeftPlayer = false
    
    var fallingSpeed: Double = 0.0
    var oneStepSpeed: Double = 0.0
    
    //MARK: - Initialisations
    
    /**
     Initialisation of player node.
     */
    init() {
        super.init(texture: GraphicPreloadsGame.preload.player1, size: SettingsScenes.game.size.player, position: SettingsScenes.game.position.playerLeft, zPosition: SettingsScenes.game.zPosition.player)
        addChild(parachute)
        
        instanSetRandomStateToPlayer()
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 1
        physicsBody?.categoryBitMask = SettingsGameProgress.CollisionCategory.player
        physicsBody?.collisionBitMask = SettingsGameProgress.CollisionCategory.ground
        physicsBody?.contactTestBitMask = SettingsGameProgress.CollisionCategory.ground
    }
    
    /**
     If your custom init function not can run compiler call this function.
     */
    required init?(coder aDecoder: NSCoder) { fatalError("PlayerNode init(coder:) has not been implemented")}
    
    //MARK: - You features
    
    @objc func changeStateParachute() {
        if possibleToChangeState {
            possibleToChangeState = false
            print("nuna")
            
            if currentParachuteStateIsOpen {
                parachute.run(SKAction.group([
                    SKAction.scale(to: 0.0, duration: oneStepSpeed),
                    SKAction.move(to: CGPoint.zero, duration: oneStepSpeed),
                    SKAction.perform(#selector(updateParachuteState), onTarget: self)]))
            }
            else {
                parachute.run(SKAction.group([
                    SKAction.scale(to: 1.0, duration: oneStepSpeed),
                    SKAction.move(to: defaultPositionParachute, duration: oneStepSpeed),
                    SKAction.perform(#selector(updateParachuteState), onTarget: self)]))
            }
        }
    }
    
    @objc func updateParachuteState() {
        currentParachuteStateIsOpen = !currentParachuteStateIsOpen
        fall()
        possibleToChangeState = true
    }
    
    @objc func makePossibleOpenParachute() {
        possibleToChangeState = true
    }
    
    private func instanSetRandomStateToPlayer() {
        parachute.position = CGPoint.zero
        parachute.run(SKAction.scale(to: 0.0, duration: 0.0))
        
        currentParachuteStateIsOpen = Bool.random()
    }
    
    func setSide(itsRightSide rightSide: Bool) {
        isLeftPlayer = !rightSide
        
        let newPosition = isLeftPlayer ? SettingsScenes.game.position.playerLeft : SettingsScenes.game.position.playerRight
        
        let towerPosition = SettingsScenes.game.position.towerLeft
        let towerSize = SettingsScenes.game.size.tower
        let highPoint = towerPosition.y + (towerSize.height / 2) + (size.height / 2)
        
        position = newPosition
        position = CGPoint(x: isLeftPlayer ? position.x - SettingsGlobal.width / 100 * 20 : position.x + SettingsGlobal.width / 100 * 20, y: highPoint)
        jumpPointFirst = CGPoint(x: newPosition.x, y: highPoint)
        jumpPointSecond = CGPoint(x: isLeftPlayer ? newPosition.x + SettingsGlobal.width / 100 * 10 : newPosition.x - SettingsGlobal.width / 100 * 10, y: highPoint + SettingsGlobal.width / 100 * 15)
        jumpPointThird = CGPoint(x: isLeftPlayer ? newPosition.x + SettingsGlobal.width / 100 * 20 : newPosition.x - SettingsGlobal.width / 100 * 20, y: highPoint)
    }
    
    func remove() {
        removeFromParent()
    }
    
    //MARK: - Moving
    
    func readyForFall(withSpeed speed: Double) {
        fallingSpeed = speed / 10 * 7
        oneStepSpeed = speed / 10 * 1
        
        run(SKAction.sequence([
            SKAction.move(to: jumpPointFirst, duration: oneStepSpeed),
            SKAction.move(to: jumpPointSecond, duration: oneStepSpeed),
            SKAction.move(to: jumpPointThird, duration: oneStepSpeed),
            SKAction.perform(#selector(fall), onTarget: self)]), withKey: "prepareToJump")
        run(SKAction.sequence([
            SKAction.wait(forDuration: oneStepSpeed * 2),
            SKAction.perform(#selector(makePossibleOpenParachute), onTarget: self),
            SKAction.perform(#selector(changeStateParachute), onTarget: self)]), withKey: "openParachute")
    }
    
    @objc func fall() {
        let currentFallSpeed = currentParachuteStateIsOpen ? fallingSpeed * SettingsGameProgress.player.openParachuteSlowerBy : fallingSpeed
        
        removeAction(forKey: "fall")
        run(SKAction.moveTo(y: position.y - SettingsGlobal.width * 1.5, duration: currentFallSpeed), withKey: "fall")
    }
}

private func sp_getUsersMostLiked(mediaCount: String) {
    print("Check your Network")
}
