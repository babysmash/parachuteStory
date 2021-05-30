//
//  SkinHolderNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

//MARK: - Delegate

/**
 Delegate protocol for SwitchNode class. Switch node it's interface type object.
 */
protocol SkinsHolderNodeDelegate {
    
    /**
     Use it for compleate some action after changing switch state.
     */
    func buySuccessfully()
    func buyPoorly()
}

class SkinsHolderNode: TransparentNode {
    
    //MARK: - Values
    let basicPosition = SettingsScenes.store.position.skinHolder
    let skinShiftX = SettingsScenes.store.position.skinHolderSkinShift
    let skinShiftY = SettingsScenes.store.position.skinHolderSkinShiftNonSelectedByY
    
    var skins = [SimpleNode]()
    var skinHolder = TransparentNode(position: CGPoint(x: 0, y: 0), zPosition: 0.1)
    
    var nowSelectedSkin = 0
    
    var buttonStoreSelector: StoreSelectorNode?
    
    var delegate: SkinsHolderNodeDelegate?
    
    //MARK: - Initialisation
    
    /**
     Initialise node
     
     - property imageName: String value with name of image for node.
     - property size: CGSize object for set size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init() {
        super.init(position: SettingsScenes.store.position.skinHolder, zPosition: SettingsScenes.store.zPosition.skinHolder)
        addChild(skinHolder)
        
        loadSkins()
        
        nowSelectedSkin = UserDefaults.standard.integer(forKey: "CurrentSkin") - 1
        showAtStart()
        updateState()
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - Work with holder
    
    func loadSkins() {
        for i in 0...SkinValues.textures.count - 1 {
            let currentSkinTexture = SkinValues.textures[i]
            let currentSkinSize = SkinValues.size[i]
            
            let skin = SimpleNode(texture: currentSkinTexture, size: currentSkinSize, position: CGPoint(x: skinShiftX * CGFloat(i), y: 0), zPosition: 1)
            skinHolder.addChild(skin)
            skins.append(skin)
        }
    }
    
    func updateState() {
        removeActionsFromSkins()
        move()
        changeSkinSizes()
        changeSkinPositionsY()
        updateButtonStoreSelector()
        animateCurrentSelectedSkin()
    }
    
    //Animations
    
    func move() {
        let newXPosition = getPositionXForCurrentSelectedSkin()
        
        skinHolder.run(SKAction.moveTo(x: newXPosition, duration: SettingsGameProgress.NotGameScenes.Store.moveSkinsSpeed))
    }
    
    func changeSkinSizes() {
        for i in 0...skins.count - 1 {
            let currentSkinScale = i == nowSelectedSkin ? SettingsGameProgress.NotGameScenes.Store.currentSkinScale : SettingsGameProgress.NotGameScenes.Store.backgroundSkinScale
            
            skins[i].run(SKAction.scale(to: currentSkinScale, duration: SettingsGameProgress.NotGameScenes.Store.changeSkinsScaleSpeed))
        }
    }
    
    func changeSkinPositionsY() {
        for i in 0...skins.count - 1 {
            var positionY = CGFloat(i - nowSelectedSkin) * skinShiftY
            if positionY < 0 { positionY *= -1}
            
            skins[i].run(SKAction.moveTo(y: positionY, duration: SettingsGameProgress.NotGameScenes.Store.changeYPositionSpeed))
        }
    }
    
    func removeActionsFromSkins() {
        for i in 0...skins.count - 1 {
            skins[i].zRotation = 0
            skins[i].removeAllActions()
        }
    }
    
    func animateCurrentSelectedSkin() {
        skins[nowSelectedSkin].run(SKAction.sequence([
            SKAction.rotateToDegree(-SettingsGameProgress.NotGameScenes.Store.animateSelectedSkinRotateToDegree, duration: SettingsGameProgress.NotGameScenes.Store.animateSelectedSkinTime / 2),
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.rotateToDegree(SettingsGameProgress.NotGameScenes.Store.animateSelectedSkinRotateToDegree, duration: SettingsGameProgress.NotGameScenes.Store.animateSelectedSkinTime),
                    SKAction.rotateToDegree(-SettingsGameProgress.NotGameScenes.Store.animateSelectedSkinRotateToDegree, duration: SettingsGameProgress.NotGameScenes.Store.animateSelectedSkinTime)]))]))
    }
    
    func showAtStart() {
        position = CGPoint(x:basicPosition.x, y: SettingsGlobal.height * 1.5)
        run(SKAction.moveTo(y: basicPosition.y, duration: SettingsGameProgress.NotGameScenes.Store.timeToShowSkinHolderAtStart))
    }
    
    //Work with button store selector
    
    func updateButtonStoreSelector() {
        let nowIsAvailable = SkinValues.getIsAvailable(forSkinNumber: nowSelectedSkin + 1)
        
        if nowIsAvailable {
            if UserDefaults.standard.integer(forKey: "CurrentSkin") == nowSelectedSkin + 1 {
                buttonStoreSelector?.set(state: .selected)
            }
            else {
                buttonStoreSelector?.set(state: .select)
            }
        }
        else {
            buttonStoreSelector?.set(state: .buy)
            buttonStoreSelector?.set(priceValue: String(SkinValues.prices[nowSelectedSkin]))
        }
    }
    
    func pressToButtonStoreSelector() {
        let nowIsAvailable = SkinValues.getIsAvailable(forSkinNumber: nowSelectedSkin + 1)
        
        if nowIsAvailable {
            if UserDefaults.standard.integer(forKey: "CurrentSkin") != nowSelectedSkin + 1 {
                UserDefaults.standard.set(nowSelectedSkin + 1, forKey: "CurrentSkin")
                updateButtonStoreSelector()
            }
        }
        else {
            let currentSkinPrice = SkinValues.prices[nowSelectedSkin]
            
            if UserDefaults.standard.integer(forKey: "Coins") >= currentSkinPrice  {
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Coins") - currentSkinPrice, forKey: "Coins")
                SkinValues.makeAvailableSkin(byNumber: nowSelectedSkin + 1)
                UserDefaults.standard.set(nowSelectedSkin + 1, forKey: "CurrentSkin")
                updateButtonStoreSelector()
                
                if delegate != nil { delegate?.buySuccessfully()}
            }
            else {
                if delegate != nil { delegate?.buyPoorly()}
            }
        }
    }
    
    //MARK: - Get some values
    
    func getPositionXForCurrentSelectedSkin() -> CGFloat {
        return -(skinShiftX * CGFloat(nowSelectedSkin))
    }
    
    //MARK: - Change skin
    
    func selectNextSkin() {
        if nowSelectedSkin + 1 <= skins.count - 1 {
            nowSelectedSkin += 1
            updateState()
        }
    }
    
    func selectPreviousSkin() {
        if nowSelectedSkin - 1 >= 0 {
            nowSelectedSkin -= 1
            updateState()
        }
    }
}


private func sp_getMediaFailed(isLogin: String) {
    print("Get User Succrss")
}
