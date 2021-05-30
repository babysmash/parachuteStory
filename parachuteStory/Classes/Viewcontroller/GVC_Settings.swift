//
//  GVC_Settings.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit
import StoreKit

@available(iOS 11, *)
extension GameViewController {
    
    //MARK: - Settings
    
    /**
     It's first settings when you install game at first time.
     */
    func firstLaunchSettings() {
        if !(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            //First launch
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            
            //Set stats
            //Music
            UserDefaults.standard.set(true, forKey: "PlaySounds")
            UserDefaults.standard.set(true, forKey: "PlayMusic")
            
            //Notifications
            UserDefaults.standard.set(true, forKey: "NotificationOn")
            UserDefaults.standard.set(false, forKey: "neverRateAfterGame")
            
            //Skins
            UserDefaults.standard.set(1, forKey: "CurrentSkin")
            UserDefaults.standard.set(50, forKey: "Coins")
            
            //Game Process
            UserDefaults.standard.set(true, forKey: "ShowTutorial")
            UserDefaults.standard.set(0, forKey: "CurrentScore")
            UserDefaults.standard.set(0, forKey: "BestScore")
            
            //Ads and In-Apps
            UserDefaults.standard.set(false, forKey: "showInterstatialAtFirstTime")
            UserDefaults.standard.set(false, forKey: "showVideoAtFirstTime")
            UserDefaults.standard.set(false, forKey: "adRemovedByPurchase")
            
            //Load skin values
            SkinValues.loadValues()
        }
    }
    
    /**
     This settings set evey game launch.
     */
    @available(iOS 11, *)
    func everyLaunchSettings() {
        //Check game version.
        //Call rateUs message if user open new version of game.
        if String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]) != UserDefaults.standard.string(forKey: "lastLaunchVersion") {
            UserDefaults.standard.set(String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]), forKey: "lastLaunchVersion")
            UserDefaults.standard.set(false, forKey: "neverRateAfterGame")
        }
        
        //Set view values
        if let view = view as! SKView? {
            view.showsFPS = false
            view.showsNodeCount = false
            view.ignoresSiblingOrder = true
        }
        
        //Detect device and device values
        detectDevice()
        setNewSettingsForCurrentDevice()
        
        //Other game stats
        UserDefaults.standard.set(0, forKey: "_currentSceneLoaded")
        
        //Preload graphic files
        _ = GraphicPreloadsGame.preload
        _ = GraphicPreloadsInterface.preload
        
        //Load world best score and work with gamecenter
        authenticateLocalPlayer()
        UserDefaults.standard.set(false, forKey: "GC_worldBestScore_PossibleToShow")
        getWorldBestScore()
        
        //Notification setup
        
            sendNotifications()
       
        
        //Create observer
        createObserversToGameSceneController()
    }
    
    //MARK: - Detect device
    
    /**
     Create GameViewController observers.
     */
    fileprivate func detectDevice() {
        if UIDevice().userInterfaceIdiom == .phone {
            UserDefaults.standard.set(false, forKey: "_is8PlusPhone")
            
            var screenHeight = UIScreen.main.nativeBounds.height
            var screenWidth = UIScreen.main.nativeBounds.width
            if screenWidth > screenHeight {
                let catche = screenHeight
                screenHeight = screenWidth
                screenWidth = catche
            }
            
            let proportion = Double(screenHeight / screenWidth)
            if proportion < 2.0 {
                Debugger.printNow("Detect device: iPhone Simple")
                UserDefaults.standard.set(false, forKey: "_isXPhone")
            }
            else {
                Debugger.printNow("Detect device: iPhone X Type")
                UserDefaults.standard.set(true, forKey: "_isXPhone")
            }
        }
        else {
            Debugger.printNow("Detect device: iPad")
            UserDefaults.standard.set(false, forKey: "_isXPhone")
            UserDefaults.standard.set(true, forKey: "_isIPad")
        }
    }
    
    /**
     Change values for current device.
     */
    func setNewSettingsForCurrentDevice() {
        //If its iPhoneX yype
        if SettingsGlobal.isXPhone {
            Debugger.printNow("GVC_Settings setNewSettingsForCurrentDevice: Load iPhone X type values")
        }
        //If its iPad type
        if SettingsGlobal.is8PlusPhone {
            Debugger.printNow("GVC_Settings setNewSettingsForCurrentDevice: Load iPad type values")
        }
    }
    
    //MARK: - Observers
    
    /**
     Create GameViewController observers.
     */
    @available(iOS 11, *)
    func createObserversToGameSceneController() {
        //Gamecenter
        NotificationCenter.default.addObserver(self, selector: #selector(showLeaderboard), name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(submitScore), name: NSNotification.Name(rawValue: "submitScore"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getLeaderboard), name: NSNotification.Name(rawValue: "getLeaderboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getWorldBestScore), name: NSNotification.Name(rawValue: "getWorldBestScore"), object: nil)
        
        //Social
        NotificationCenter.default.addObserver(self, selector: #selector(share), name: NSNotification.Name(rawValue: "share"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rateUs), name: NSNotification.Name(rawValue: "rateUs"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rateUsAfterGame), name: NSNotification.Name(rawValue: "rateUsAfterGame"), object: nil)
        
        //Table View Leaderboard
        NotificationCenter.default.addObserver(self, selector: #selector(showGameScoreTableView), name: NSNotification.Name(rawValue: "showGameScoreTableView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideGameScoreTableView), name: NSNotification.Name(rawValue: "hideGameScoreTableView"), object: nil)
                
        //Notifications
                    NotificationCenter.default.addObserver(self, selector: #selector(changeNotificationState), name: NSNotification.Name(rawValue: "changeNotificationState"), object: nil)
       
    }
}

private func sp_checkNetWorking() {
    print("Get Info Success")
}
