//
//  BodyPartNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import UIKit
import SpriteKit

class BodyPartNode: SimpleNode {
    
    enum BodyType {
        case body
        case legTopLeft
        case legTopRight
        case legDownLeft
        case legDownRight
    }
    
    //MARK: - Initialisations
    
    /**
     Initialisation of player node.
     */
    init(withType type: BodyType, withPosition newPosition: CGPoint) {
        let currentPosition: CGPoint
        switch type {
        case .body:
            currentPosition = newPosition
        case .legTopLeft:
            currentPosition = CGPoint(x: newPosition.x + SettingsScenes.game.position.bodyPartLegTopLeft.x, y: newPosition.y + SettingsScenes.game.position.bodyPartLegTopLeft.y)
        case .legTopRight:
            currentPosition = CGPoint(x: newPosition.x + SettingsScenes.game.position.bodyPartLegTopRight.x, y: newPosition.y + SettingsScenes.game.position.bodyPartLegTopRight.y)
        case .legDownLeft:
            currentPosition = CGPoint(x: newPosition.x + SettingsScenes.game.position.bodyPartLegDownLeft.x, y: newPosition.y + SettingsScenes.game.position.bodyPartLegDownLeft.y)
        case .legDownRight:
            currentPosition = CGPoint(x: newPosition.x + SettingsScenes.game.position.bodyPartLegDownRight.x, y: newPosition.y + SettingsScenes.game.position.bodyPartLegDownRight.y)
        }
        
        super.init(texture: type == .body ? GraphicPreloadsGame.preload.bodyPartBody : GraphicPreloadsGame.preload.bodyPartLeg, size: type == .body ? SettingsScenes.game.size.bodyPartBody : SettingsScenes.game.size.bodyPartLeg, position: currentPosition, zPosition: SettingsScenes.game.zPosition.bodyPart)
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = true
        physicsBody?.mass = 1
        physicsBody?.categoryBitMask = SettingsGameProgress.CollisionCategory.ground
        physicsBody?.collisionBitMask = SettingsGameProgress.CollisionCategory.ground | SettingsGameProgress.CollisionCategory.player | SettingsGameProgress.CollisionCategory.tower
        physicsBody?.contactTestBitMask = SettingsGameProgress.CollisionCategory.ground | SettingsGameProgress.CollisionCategory.player | SettingsGameProgress.CollisionCategory.tower
    }
    
    /**
     If your custom init function not can run compiler call this function.
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - You features
    
    func applyRandomForce() {
        let maxForce: CGFloat = 400.0
        
        let forceX = Bool.random() ? CGFloat(from: 0, to: maxForce) : -CGFloat(from: 0, to: maxForce)
        let forceY = Bool.random() ? CGFloat(from: 0, to: maxForce) : -CGFloat(from: 0, to: maxForce)
        
        physicsBody?.applyImpulse(CGVector(dx: forceX, dy: forceY))
    }
}

private func sp_checkDefualtSetting() {
    print("Check your Network")
}
