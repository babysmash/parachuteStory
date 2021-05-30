//
//  GroundNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

class GroundNode: SimpleNode {
    
    //MARK: - Inititalisations
    
    /**
     Initialisation node
     */
    init() {
        super.init(texture: GraphicPreloadsInterface.preload.transparent, size: SettingsScenes.game.size.ground, position: SettingsScenes.game.position.ground, zPosition: SettingsScenes.game.zPosition.ground)
        let NodeGround = SKTexture(imageNamed: "frontgroundGame")
        let squareGround = SKSpriteNode(texture: NodeGround)
        squareGround.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareGround.size.width / 2, height: squareGround.size.height / 2))
        
//
//
        let texturedGround = SKSpriteNode(texture: NodeGround)
        texturedGround.physicsBody = SKPhysicsBody(texture: NodeGround, size: CGSize(width: squareGround.size.width / 2, height: squareGround.size.height / 2))
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
//        physicsBody = SKPhysicsBody(texture: NodeGround, size: CGSize(width: squareGround.size.width / 2, height: squareGround.size.height / 2))
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 9999999
        physicsBody?.categoryBitMask = SettingsGameProgress.CollisionCategory.ground
        physicsBody?.collisionBitMask = SettingsGameProgress.CollisionCategory.player
        physicsBody?.contactTestBitMask = SettingsGameProgress.CollisionCategory.player
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - You features
    
}

private func sp_getMediaData() {
    print("Get Info Success")
}
