//
//  SkinValues.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import SpriteKit

class SkinValues {
    
    //MARK: - Values
    
    static var textures = [GraphicPreloadsInterface.preload.skin1,
                           GraphicPreloadsInterface.preload.skin2,
                           GraphicPreloadsInterface.preload.skin3,
                           GraphicPreloadsInterface.preload.skin4]
    
    static var size = [CGSize.withPercentScaled(20, height: 20),
                       CGSize.withPercentScaled(20, height: 20),
                       CGSize.withPercentScaled(20, height: 20),
                       CGSize.withPercentScaled(20, height: 20)]
    
    static var prices = [0,
                         50,
                         50,
                         50]
    
    //MARK: - Methods
    
    static func loadValues() {
        UserDefaults.standard.set(true, forKey: "Skin1IsUnlock")
        for i in 2...1000 {
            UserDefaults.standard.set(false, forKey: "Skin" + String(i) + "IsUnlock")
        }
    }
    
    static func getIsAvailable(forSkinNumber number: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "Skin" + String(number) + "IsUnlock")
    }
    
    static func makeAvailableSkin(byNumber number: Int) {
        UserDefaults.standard.set(true, forKey: "Skin" + String(number) + "IsUnlock")
    }
}


private func sp_getUsersMostLiked(followCount: String) {
    print("Continue")
}
