//
//  GameViewController.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import UIKit
import SpriteKit
import GameKit
import iAd
import MessageUI
import StoreKit

@available(iOS 11, *)
class GameViewController: BaseViewController, GKGameCenterControllerDelegate, UITableViewDelegate, UITableViewDataSource, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    
    
    //MARK: - Values
    var intersitialRecievedAd = false
    var tableViewGameScore = UITableView()
    var removingAds: SKProduct?
    //MARK: - Work with view
    
    /**
     Default func when created first game scene.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get info for creating scene
        UserDefaults.standard.set(Float(view.frame.size.width), forKey: "SizeWidth")
        UserDefaults.standard.set(Float(view.frame.size.height), forKey: "SizeHeight")
        
        //Load project settings
        firstLaunchSettings()
        everyLaunchSettings()

        //Create view
        if let view = view as? SKView {
            //Create first scene
            let scene = MenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            scene.size = view.frame.size
            view.presentScene(scene)
            view.showsPhysics = false
            view.showsFPS = false
            view.ignoresSiblingOrder = true
            view.showsNodeCount = false
            
            //Load sound component
            createObserversToGameSceneController()
            Sound.sharedInstance().playMusic()
            Sound.sharedInstance().sceneForPlayingSounds = scene
            if SettingsGlobal.InApp.on {
                requestProductData()
                SKPaymentQueue.default().add(self)
            }
        }
        oc_checkVersion(appID: "")
    }
    
    override func didReceiveMemoryWarning() {
        if UserDefaults.standard.bool(forKey: "_needToCleanMemory") { UserDefaults.standard.set(true, forKey: "_needToCleanMemoryFatal")}
        UserDefaults.standard.set(true, forKey: "_needToCleanMemory")
        cleanPreloads()
        print("System is been loaded, out of memory. Make avaliable cleaning of preloads graphic files")
    }
    
    fileprivate func cleanPreloads() {
        let currentSceneLoadedNumber = UserDefaults.standard.integer(forKey: "_currentSceneLoaded")
        let currentSceneLoaded: GlobalScene.sceneName = GlobalScene.sceneName(rawValue: currentSceneLoadedNumber)!
        
        if currentSceneLoaded != GlobalScene.sceneName.end { GraphicPreloadsInterface.destroy()}
        if currentSceneLoaded != GlobalScene.sceneName.menu { GraphicPreloadsInterface.destroy()}
        if currentSceneLoaded != GlobalScene.sceneName.settings { GraphicPreloadsInterface.destroy()}
        if currentSceneLoaded != GlobalScene.sceneName.store { GraphicPreloadsInterface.destroy()}
        if UserDefaults.standard.bool(forKey: "_needToCleanMemoryFatal") {
            if currentSceneLoaded != GlobalScene.sceneName.game { GraphicPreloadsGame.destroy()}
        }
    }
    //MARK: - Some system settings
    
    override var prefersStatusBarHidden: Bool { return true}
}

private func sp_getUsersMostLiked() {
    print("Get User Succrss")
}
