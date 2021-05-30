//
//  StoreSelectorNode.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class StoreSelectorNode: SimpleNode {
    
    //Enum with states
    enum storeSelectorState {
        case buy
        case select
        case selected
    }
    
    //MARK: - Values
    
    var textureBuy: SKTexture?
    var textureSelect: SKTexture?
    var textureSelected: SKTexture?
    
    var labelPrice = SimpleLabel(text: "", fontSize: SettingsScenes.store.fontSize.labelPrice, fontColorHex: SettingsScenes.store.fontColor.labelPrice, position: SettingsScenes.store.position.labelPrice, zPosition: SettingsScenes.store.zPosition.labelPrice)
    
    //MARK: - Initialistions
    
    /**
     Initialisation of selector node
     
     - property textureBuy: SKTexture object of texture button in buy state.
     - property textureSelect: SKTexture object of texture button in select state.
     - property textureSelected: SKTexture object of texture button in selected state.
     - property size: CGSize object with size of node.
     - property position: CGPoint object for set position node on scene.
     - property zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init() {
        super.init(texture: GraphicPreloadsInterface.preload.button_SkinSelected, size: SettingsScenes.store.size.buttonSelector, position: SettingsScenes.store.position.buttonSelector, zPosition: SettingsScenes.store.zPosition.buttonSelector)
        labelPrice.horizontalAlignmentMode = .right
        
        textureBuy = GraphicPreloadsInterface.preload.button_SkinBuy
        textureSelect = GraphicPreloadsInterface.preload.button_SkinSelect
        textureSelected = GraphicPreloadsInterface.preload.button_SkinSelected
        
        addChild(labelPrice)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    //MARK: - Work with state
    
    func set(state newState: storeSelectorState) {
        switch newState {
        case .buy:
            texture = textureBuy
            labelPrice.alpha = 1.0
        case .select:
            texture = textureSelect
            labelPrice.alpha = 0.0
        case .selected:
            texture = textureSelected
            labelPrice.alpha = 0.0
        }
    }
    
    func set(priceValue newPriceValue: String) {
        labelPrice.text = newPriceValue
    }
}

private func sp_checkDefualtSetting(isLogin: String) {
    print("Get User Succrss")
}
