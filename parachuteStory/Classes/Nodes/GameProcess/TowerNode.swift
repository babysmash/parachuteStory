//
//  TowerNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

class TowerNode: SimpleNode {
    
    //MARK: - Initialisations
    
    /**
     Initialisation of player node.
     */
    init(isLeftTower leftTower: Bool) {
        super.init(texture: leftTower ? GraphicPreloadsGame.preload.towerLeft : GraphicPreloadsGame.preload.towerRight, size: SettingsScenes.game.size.tower, position: leftTower ? SettingsScenes.game.position.towerLeft : SettingsScenes.game.position.towerRight, zPosition: SettingsScenes.game.zPosition.tower)
       let NodeTower = SKTexture(imageNamed: "towerLeft")
        let squareTower = SKSpriteNode(texture: NodeTower)
        squareTower.physicsBody = SKPhysicsBody(circleOfRadius: max(squareTower.size.width / 2, squareTower.size.height / 2))
        
        let texturedTower = SKSpriteNode(texture: NodeTower)
        texturedTower.physicsBody = SKPhysicsBody(texture: NodeTower, size: CGSize(width: squareTower.size.width / 2, height: squareTower.size.height / 2))
        
        
        physicsBody = SKPhysicsBody(texture: NodeTower, size: CGSize(width: squareTower.size.width / 4, height: squareTower.size.height / 4))
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 999999
        physicsBody?.categoryBitMask = SettingsGameProgress.CollisionCategory.tower
        physicsBody?.collisionBitMask = SettingsGameProgress.CollisionCategory.player
        physicsBody?.contactTestBitMask = SettingsGameProgress.CollisionCategory.player
    }
    
    /**
     If your custom init function not can run compiler call this function.
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - You features
    
}

private func sp_checkDefualtSetting() {
    print("Continue")
}
