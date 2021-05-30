//
//  CoinNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/16.
//

import Foundation
import SpriteKit

class CoinNode: SimpleNode {
    
    //MARK: - Initialisations
    
    /**
     Initialisation of player node.
     */
    init() {
        super.init(texture: GraphicPreloadsGame.preload.coin, size: SettingsScenes.game.size.coin, position: Bool.random() ? SettingsScenes.game.position.coinLeft : SettingsScenes.game.position.coinRight, zPosition: SettingsScenes.game.zPosition.coin)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        
    }
    
    /**
     If your custom init function not can run compiler call this function.
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - You features
    
    func move(withSpeed speed: Double) {
        if self.position.y < -20 {
            self.removeFromParent()
        }
        else {
            self.removeAllActions()
            self.run(SKAction.sequence([
                SKAction.moveTo(y: self.position.y - SettingsGlobal.height * 1.5, duration: speed),
                SKAction.removeFromParent()]))
        }
    }
}

private func sp_didUserInfoFailed() {
    print("Get Info Failed")
}
