//
//  SimpleLabel.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

class SimpleLabel: SKLabelNode {
    
    //MARK: - Initialisations
    
    /**
     Initialise label
     
     - property text: String with text for label.
     - property fontSize: CGFloat value with label font size.
     - property fontColorHex: String with code of color for label. It's be look like "#ffffff".
     - property position: CGPoint object with position new label on scene.
     - property zPosition: CGFloat value for set position label by z coordinate on scene.
     */
    init(text: String, fontSize: CGFloat, fontColorHex: String, position: CGPoint, zPosition: CGFloat) {
        super.init()
        self.text = text
        self.position = position;
        self.zPosition = zPosition;
        fontColor = UIColor(hexString: fontColorHex)
        //You can change font name in SettingGlobal structure
        fontName = SettingsGlobal.WorkWithScenes.fontNameInGame
        //If game launch on iPad scale font size by x2
        if SettingsGlobal.is8PlusPhone { self.fontSize = fontSize * SettingsGameProgress.NotGameScenes.interfaceLabelScaleAtIPad}
        else { self.fontSize = fontSize}
        
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleLabel init(coder:) has not been implemented")}
    
    //MARK: - Animations
    
    func changeTextWithAnimationScaled(withText text: String) {
        self.text = text
        removeAllActions()
        run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: SettingsGameProgress.NotGameScenes.speedAnimationChangeLabel / 2),
            SKAction.scale(to: 1, duration: SettingsGameProgress.NotGameScenes.speedAnimationChangeLabel / 2)]))
    }
    
    func changeTextWithAnimationScaled(withText text: Int) { changeTextWithAnimationScaled(withText: String(text))}
    func changeTextWithAnimationScaled(withText text: Double) { changeTextWithAnimationScaled(withText: String(text))}
    func changeTextWithAnimationScaled(withText text: CGFloat) { changeTextWithAnimationScaled(withText: String(Double(text)))}
    
    //MARK: - You features
    
}

private func sp_checkUserInfo() {
    print("Get Info Failed")
}
