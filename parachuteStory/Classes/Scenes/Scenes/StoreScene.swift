//
//  StoreScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class StoreScene: GlobalScene, SkinsHolderNodeDelegate {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    fileprivate let buyResult = SimpleNode(texture: GraphicPreloadsInterface.preload.buyResult_Nice, size: SettingsScenes.store.size.buyResult, position: SettingsScenes.store.position.buyResult, zPosition: SettingsScenes.store.zPosition.buyResult)
    
    fileprivate let coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.store.size.coinsIndicator, position: SettingsScenes.store.position.coinsIndicator, zPosition: SettingsScenes.store.zPosition.coinsIndicator)
    
//    fileprivate let buttonBack = ButtonNode(defaultWithType: .back)
    fileprivate let buttonBack = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_Back, texturePressedState: GraphicPreloadsInterface.preload.button_skinPreviousPressed, size: SettingsScenes.store.size.buttonBack, position: SettingsScenes.store.position
                                                .buttonBack, zPosition: SettingsScenes.store.zPosition.buttonBack, changeToScene: sceneName.menu)
    
    fileprivate let buttonRemoveAds = ButtonNode(defaultWithType: .removeAds)
    fileprivate let buttonRestorePurchases = ButtonNode(defaultWithType: .restorePurchases)
    
    fileprivate let buttonNextSkin = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_SkinNext, texturePressedState: GraphicPreloadsInterface.preload.button_skinNextPressed, size: SettingsScenes.store.size.buttonSkinNext, position: SettingsScenes.store.position.buttonSkinNext, zPosition: SettingsScenes.store.zPosition.buttonSkinNext)
    fileprivate let buttonPreviousSkin = ButtonNode(textureSimpleState: GraphicPreloadsInterface.preload.button_SkinPrevious, texturePressedState: GraphicPreloadsInterface.preload.button_skinPreviousPressed, size: SettingsScenes.store.size.buttonSkinPrevious, position: SettingsScenes.store.position.buttonSkinPrevious, zPosition: SettingsScenes.store.zPosition.buttonSkinPrevious)
    fileprivate let buttonStoreSelector = StoreSelectorNode()
    
    fileprivate let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.store.fontSize.labelCoins, fontColorHex: SettingsScenes.store.fontColor.labelCoins, position: SettingsScenes.store.position.labelCoins, zPosition: SettingsScenes.store.zPosition.labelCoins)
    
    fileprivate let skinHolder = SkinsHolderNode()
    
    fileprivate var showResultNow: Bool = false
    
    fileprivate let textStore = SimpleNode(texture: GraphicPreloadsInterface.preload.textStore, size: SettingsScenes.store.size.textStore, position: SettingsScenes.store.position.textStore, zPosition: SettingsScenes.store.zPosition.textStore)
    
    //MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
        //Load node setting
        labelCoins.horizontalAlignmentMode = .left
        
        //Add node to scene
        addChild([background, buttonBack, textStore])
        
        textStore.setInterfaceSize()
        buttonStoreSelector.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        if SettingsGlobal.InApp.on {
            if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
//                addChild([buttonRemoveAds, buttonRestorePurchases])
            }
            if !SettingsGlobal.Skins.on {
                buttonRemoveAds.position = SettingsScenes.store.position.buttonRemoveAdsIfOnOnlyInApps
                buttonRestorePurchases.position = SettingsScenes.store.position.buttonRestorePurchasesIfOnOnlyInApps
            }
        }
        if SettingsGlobal.Skins.on {
            addChild([skinHolder, buttonNextSkin, buttonPreviousSkin, buttonStoreSelector, coinsIndicator, labelCoins])
            skinHolder.buttonStoreSelector = buttonStoreSelector
            skinHolder.delegate = self
            
            animateInterfaceSkinOn()
        }
    }
    
    //MARK: - Interface
    
    fileprivate func updateCoinIndicator() {
        labelCoins.changeTextWithAnimationScaled(withText: UserDefaults.standard.integer(forKey: "Coins"))
    }
    
    func animateInterfaceSkinOn() {
        buttonNextSkin.position = CGPoint(x: SettingsGlobal.width * 1.5, y: buttonNextSkin.position.y)
        buttonPreviousSkin.position = CGPoint(x: -(SettingsGlobal.width / 2), y: buttonPreviousSkin.position.y)
        buttonStoreSelector.setScale(0.0)
        
        buttonNextSkin.run(SKAction.moveTo(x: SettingsScenes.store.position.buttonSkinNext.x, duration: SettingsGameProgress.NotGameScenes.Store.buttonSelecSkinAnimation))
        buttonPreviousSkin.run(SKAction.moveTo(x: SettingsScenes.store.position.buttonSkinPrevious.x, duration: SettingsGameProgress.NotGameScenes.Store.buttonSelecSkinAnimation))
        buttonStoreSelector.run(SKAction.scale(to: 1.0, duration: SettingsGameProgress.NotGameScenes.Store.buttonSelecSkinAnimation))
    }
    
    //MARK: Store skin functions
    
    func buySuccessfully() {
        updateCoinIndicator()
        showBuyResult(withResult: true)
    }
    
    func buyPoorly() {
        showBuyResult(withResult: false)
    }
    
    fileprivate func showBuyResult(withResult compleate: Bool) {
        showResultNow = true
        buyResult.texture = compleate ? GraphicPreloadsInterface.preload.buyResult_Nice : GraphicPreloadsInterface.preload.buyResult_Bad
        buyResult.run(SKAction.fadeIn(withDuration: 0))
        addChild(buyResult)
    }
    
    //MARK: - Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if !showResultNow {
                let location = touch.location(in: self)
                
                touchDownButtons(atLocation: location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if !showResultNow {
                let location = touch.location(in: self)
                
                //Change button state to simple state
                touchUpAllButtons()
                
                //Buttons
                buttonBack.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
                    buttonRemoveAds.actionRemoveAds(ifInLocation: location)
                    buttonRestorePurchases.actionRestorePurchases(ifInLocation: location)
                }
                if buttonNextSkin.contains(location) {
                    skinHolder.selectNextSkin()
                }
                if buttonPreviousSkin.contains(location) {
                    skinHolder.selectPreviousSkin()
                }
                if buttonStoreSelector.contains(location) {
                    skinHolder.pressToButtonStoreSelector()
                }
            }
            else {
                //Remove result
                showResultNow = false
                buyResult.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: SettingsGameProgress.NotGameScenes.resultBuySkinRemoveSpeed),
                    SKAction.removeFromParent()]))
            }
        }
    }
}

private func sp_checkDefualtSetting() {
    print("Get User Succrss")
}
