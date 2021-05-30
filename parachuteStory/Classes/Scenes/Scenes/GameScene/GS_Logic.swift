//
//  GS_Logic.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

extension GameScene {
    
    //MARK: - Setters
    
    func setPlayer(toSideLeft isLeftSide: Bool) {
        if !isLeftSide {
            playerLeft = PlayerNode()
            playerLeft.setSide(itsRightSide: true)
            playerLeft.readyForFall(withSpeed: playerSpeed)
            addChild(playerLeft)
        }
        else {
            playerRight = PlayerNode()
            playerRight.setSide(itsRightSide: false)
            playerRight.readyForFall(withSpeed: playerSpeed)
            addChild(playerRight)
        }
    }
    
    func setGround() {
        addChild(GroundNode())
    }
    
    func setTower() {
        addChild(TowerNode(isLeftTower: true))
        addChild(TowerNode(isLeftTower: false))
    }
    
    func setPlayerParticles(toPosition positionToSet: CGPoint) {
        let bodyPartBody = BodyPartNode(withType: .body, withPosition: positionToSet)
        let bodyPartLegTopLeft = BodyPartNode(withType: .legTopLeft, withPosition: positionToSet)
        let bodyPartLegTopRight = BodyPartNode(withType: .legTopRight, withPosition: positionToSet)
        let bodyPartLegDownLeft = BodyPartNode(withType: .legDownLeft, withPosition: positionToSet)
        let bodyPartLegDownRight = BodyPartNode(withType: .legDownRight, withPosition: positionToSet)
        addChild(bodyPartBody)
        addChild(bodyPartLegTopLeft)
        addChild(bodyPartLegTopRight)
        addChild(bodyPartLegDownLeft)
        addChild(bodyPartLegDownRight)
        
        bodyPartBody.applyRandomForce()
        bodyPartLegTopLeft.applyRandomForce()
        bodyPartLegTopRight.applyRandomForce()
        bodyPartLegDownLeft.applyRandomForce()
        bodyPartLegDownRight.applyRandomForce()
    }
    
    //MARK: - Game actions
    
    func tryToChangeParachuteState(withPressPosition positionPress: CGPoint) {
        if positionPress.x < SettingsGlobal.width / 2 {
            playerRight.changeStateParachute()
        }
        else {
            playerLeft.changeStateParachute()
        }
    }
    
}

private func sp_didUserInfoFailed(string: String) {
    print("Get Info Success")
}
