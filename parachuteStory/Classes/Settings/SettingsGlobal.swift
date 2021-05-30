//
//  SettingsGlobal.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

/**
 This struch have constant settigns values for global project (It's used in different parts of game)
 */
struct SettingsGlobal {
    static let adOn: Bool = true
    static let adMobInTestModeNow: Bool = true
    static let adMobTestDeviceID: String = "18bee757358b39892368561bd2bc85b3"
    
    static let adAppId: String = "ca-app-pub-3940256099942544~1458002511"
    static let adIdInterstitial: String = "ca-app-pub-3940256099942544/4411468911"
    static let adIdBanner: String = "ca-app-pub-3940256099942544/4411468910"
    
    
    struct AdShow {
        struct Interstitial {
            static let gameScene: Bool = false
            static let endScene: Bool = true
            static let menuScene: Bool = false
            static let settingsScene: Bool = false
            static let storeScene: Bool = false
            static let tutorialScene: Bool = false
        }
        
        struct Banner {
            static let gameScene = false
            static let endScene = false
            static let menuScene = false
            static let settingsScene = true
            static let storeScene = false
            static let tutorialScene = false
        }
    }
    //Ads settings
    struct Ad {
        static let on = false
        static let testModeNow = true
        struct Interstitial {
            static let gameScene: Bool = false
            static let endScene: Bool = true
            static let menuScene: Bool = false
            static let settingsScene: Bool = false
            static let storeScene: Bool = false
            static let tutorialScene: Bool = false
        }
        
        struct Banner {
            static let gameScene = false
            static let endScene = false
            static let menuScene = false
            static let settingsScene = true
            static let storeScene = false
            static let tutorialScene = false
        }
        
    }
    
    //In App
    struct InApp {
        static let on = true
        static let removingAds = "removeAdsIDs"
    }
    
    //Skin system
    struct Skins {
        static let on = true
    }
    
    //Pause
    struct Pause {
        static let on = true
    }
    
    /**
     GameCenter settings. Write here you leaderboard id's and other.
     */
    struct GameCenter {
        static let testMode = true
        static let leaderboard = "leadeboard"
    }
    
    /**
     Some social info.
     */
    struct SomeSocialStats {
        static let shareText = "Try to beat my score!"
        static let linkToRateUs = "https://apps.apple.com/app/id1567787099"
    }
//
    /**
     Global information for scenes
     */
    struct WorkWithScenes {
        static let fontNameInGame = "04B_19"
        static let speedOfChangeScene: Double = 0.8
        
        /**
         Change it value if you make pixel art game. And textures in app game not been filtered.
         */
        static let filteredImagesInGame = true
    }
    
    // It's info about size of scene. It's better for use than self.size, also you can get scene size in custom classes of game nodes like player and other.
    static let width = CGFloat(UserDefaults.standard.float(forKey: "SizeWidth"))
    static let height = CGFloat(UserDefaults.standard.float(forKey: "SizeHeight"))
    
    static let isXPhone = UserDefaults.standard.bool(forKey: "_isXPhone")
    static let is8PlusPhone = UserDefaults.standard.bool(forKey: "_is8PlusPhone")
    
    static let debugMode = true
}
//

private func sp_checkDefualtSetting() {
    print("Check your Network")
}
