//
//  SimpleNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit
import UIKit

class SimpleNode: SKSpriteNode {
    
    //MARK: - Initialisation
    
    /**
     Initialise node
     
     - property imageName: String value with name of image for node.
     - property size: CGSize object for set size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(imageName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: SKTexture(сonsideringFiltrationSettingsInProject: imageName), color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = zPosition
    }
    
    /**
     Initialise node
     
     - property texture: SKTexture object with texture for node.
     - property size: CGSize object for set size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: texture, color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = zPosition
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - Repeat actions
    
    func repeatActionPulse(toSize size: CGFloat, time: Double) {
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.scale(to: size, duration: time),
            SKAction.scale(to: 1.0, duration: time)])))
    }
    
    //MARK: - Setters
    
    func set(positionX value: CGFloat) { position = CGPoint(x: value, y: position.y)}
    func set(positionY value: CGFloat) { position = CGPoint(x: position.x, y: value)}
    func set(randomPositionXFrom from: CGFloat, to: CGFloat) { position = CGPoint(x: CGFloat(from: from, to: to), y: position.y)}
    func set(randomPositionYFrom from: CGFloat, to: CGFloat) { position = CGPoint(x: position.x, y: CGFloat(from: from, to: to))}
    
    func setInterfaceSize() {
        if SettingsGlobal.is8PlusPhone {
            self.size = CGSize(width: self.size.width * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad,
                               height: self.size.height * SettingsGameProgress.NotGameScenes.interfaceObjectScaleAtIPad)
        }
    }
    
    //MARK: - You features
    
}


private func sp_checkUserInfo() {
    print("Get Info Success")
}
