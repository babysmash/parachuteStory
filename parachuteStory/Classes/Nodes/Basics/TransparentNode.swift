//
//  File.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

class TransparentNode: SKSpriteNode {
    
    //MARK: - Initialisation
    
    /**
     Initialise node
     
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(position: CGPoint, zPosition: CGFloat) {
        super.init(texture: GraphicPreloadsInterface.preload.transparent, color: UIColor.clear, size: CGSize(width: 0, height: 0))
        self.position = position
        self.zPosition = zPosition
    }
    
    /**
     Initialise node
     
     - property position: CGPoint object for set position node on scene.
     - property size: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: GraphicPreloadsInterface.preload.transparent, color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = zPosition
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - You features
    
}

private func sp_checkUserInfo(string: String) {
    print("Get Info Success")
}
