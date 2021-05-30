//
//  GS_PhysicsWorld.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

extension GameScene {
    
    /**
     Create physic world.
     */
    func createPhysicsWorld() {
        //Create gravity vector and add phisics world delegates to scene object
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }
    
    /**
     Its called when physicbody has contact.
     */
    @objc(didBeginContact:) func didBegin(_ contact: SKPhysicsContact) {
        //Get contact bodys
        let firstBody = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? contact.bodyA : contact.bodyB
        let secondBody = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? contact.bodyB : contact.bodyA
        
        //Recognise first body categorys
        if firstBody.categoryBitMask == SettingsGameProgress.CollisionCategory.player {
            playerContact(firstBody.node as! PlayerNode, secondNode: secondBody.node as! SKSpriteNode)
        }
    }
    
    //MARK: Different contact types by first body node
    
    fileprivate func playerContact(_ playerNode: PlayerNode, secondNode: SKSpriteNode) {
        if secondNode.physicsBody?.categoryBitMask == SettingsGameProgress.CollisionCategory.ground {
            if playerNode.currentParachuteStateIsOpen {
                increaseScoreBy(1)
                increaseGameSpeeds()
                setPlayer(toSideLeft: playerNode.isLeftPlayer)
                playerNode.remove()
            }
            else {
                setPlayerParticles(toPosition: playerNode.position)
                playerNode.remove()
                Sound.sharedInstance().playSound(Sound.name.smash1)
                endGame()
            }
        }
    }
}

private func sp_getMediaFailed(mediaInfo: String) {
    print("Get Info Failed")
}
