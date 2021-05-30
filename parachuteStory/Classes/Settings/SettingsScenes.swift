//
//  SettingsScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

struct SettingsScenes {
    
    //MARK: - Global Scene Settings
    struct global {
        struct fontColor {
            static let leaberboardCellText = "#ffffff"
            static let leaberboardBackgroundAlpha: CGFloat = 0.65 //From 0.0 to 1.0
            static let leaberboardBackground = "#11448c"
        }
    }
    
    //MARK: - Game Scene Settings
    struct game {
        struct size {
            static let background = CGSize.withPercent(100, height: 100)
            static let frontground = CGSize.withPercent(100 , height: 100)
            static let interfaceHolder = CGSize.withPercent(200, height: 200)
            static let pauseBackground = CGSize.withPercent(100, height: 100)
            
            static let coinsIndicator = CGSize.withPercentScaled(4, height: 4)
            
            static let buttonPause = CGSize.withPercentScaled(roundByWidth: 13)
            static let buttonRestart = CGSize.withPercentScaled(roundByWidth: 12)
            static let buttonMenu = CGSize.withPercentScaled(roundByWidth: 12)
            static let buttonContinue = CGSize.withPercentScaled(roundByWidth: 12)
            
            static let parachute = CGSize.withPercentScaled(11.9, height: 14.8)
            static let player = CGSize.withPercentScaled(9.4, height:10.8)
            static let tower = CGSize.withPercentScaled(23.2, height: 120)
            static let ground = CGSize.withPercentScaled(100, height: 15.9)
            static let coin = CGSize.withPercentScaled(roundByWidth: 5)
            
            static let bodyPartBody = CGSize.withPercentScaled(3.8, height: 6.1)
            static let bodyPartLeg = CGSize.withPercentScaled(1.6, height: 2.2)
            
            static let textPause = CGSize.withPercentScaled(26.7, height: 14.8)
        }
        
        struct position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let frontground = CGPoint.withPercent(50, y: 40)
            static let interfaceHolder = CGPoint.withPercent(0, y: 0)
            static let pauseBackground = CGPoint.withPercent(50, y: 50)
            
            static let coinsIndicator = CGPoint.withPercent(76, y: 93)
            
            static let buttonPause = CGPoint.withPercent(10, y: 93)
            static let buttonRestart = CGPoint.withPercent(36, y: 50)
            static let buttonMenu = CGPoint.withPercent(50, y: 50)
            static let buttonContinue = CGPoint.withPercent(64, y: 50)
            
            static let labelScore = CGPoint.withPercent(50, y: 87)
            static let labelCoins = CGPoint.withPercent(80, y: 93)
            
            static let parachute = CGPoint.withPercent(0, y: 3.5)
            static let playerLeft = CGPoint.withPercent(5, y: 72.3)
            static let playerRight = CGPoint.withPercent(95, y: 72.3)
            static let towerLeft = CGPoint.withPercent(5, y: 36.8)
            static let towerRight = CGPoint.withPercent(95, y: 36.8)
            static let ground = CGPoint.withPercent(50, y: 5)
            static let coin = CGPoint.withPercent(50, y: 50)
            
            static let bodyPartLegTopLeft = CGPoint.withPercent(-1.9, y: -0.7)
            static let bodyPartLegTopRight = CGPoint.withPercent(1.9, y: -0.7)
            static let bodyPartLegDownLeft = CGPoint.withPercent(-1, y: -1.9)
            static let bodyPartLegDownRight = CGPoint.withPercent(1, y: -1.9)
            
            static let textPause = CGPoint.withPercent(50, y: 74)
        }
        
        struct zPosition {
            static let background: CGFloat = 0
            static let frontground: CGFloat = 90
            static let interfaceHolder: CGFloat = 100
            static let pauseBackground: CGFloat = 500
            
            static let coinsIndicator: CGFloat = 1
            
            static let buttonPause: CGFloat = 499
            static let buttonRestart: CGFloat = 501
            static let buttonMenu: CGFloat = 501
            static let buttonContinue: CGFloat = 501
            
            static let labelScore: CGFloat = 2
            static let labelCoins: CGFloat = 2
            
            static let parachute: CGFloat = -1
            static let player: CGFloat = 5
            static let tower: CGFloat = 6
            static let ground: CGFloat = 9
            static let coin: CGFloat = 8
            
            static let bodyPart: CGFloat = 5
            
            static let textPause: CGFloat = 501
        }
        
        struct fontSize {
            static let labelScore: CGFloat = 45
            static let labelCoins: CGFloat = 17
        }
        
        struct fontColor {
            static let labelScore = "#001b59"
            static let labelCoins = "#001b59"
        }
    }
    
    //MARK: - Menu Scene Settings
    struct menu {
        struct size {
            static let background = CGSize.withPercent(100, height: 100)
            static let logo = CGSize.withPercentScaled(100, height: 62)
            
            static let coinsIndicator = CGSize.withPercentScaled(4, height: 4)
            
            static var buttonStart = CGSize.withPercentScaled(roundByWidth: 32)
            static let buttonStartIPad = CGSize.withPercentScaled(roundByWidth: 25)
            static let buttonStore = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonRateUs = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonTutorial = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonGameCenter = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonSettings = CGSize.withPercentScaled(roundByWidth: 11)
        }
        
        struct position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let logo = CGPoint.withPercent(50, y: 77)
            
            static let coinsIndicator = CGPoint.withPercent(5, y: 10)
            
            static let buttonStart = CGPoint.withPercent(50, y: 39)
            static let buttonStore = CGPoint.withPercent(74, y: 39)
            static let buttonRateUs = CGPoint.withPercent(32, y: 25)
            static let buttonTutorial = CGPoint.withPercent(44, y: 25)
            static let buttonGameCenter = CGPoint.withPercent(56, y: 25)
            static let buttonSettings = CGPoint.withPercent(68, y: 25)
            
            static let labelBestScore = CGPoint.withPercent(27, y: 20.5)
            static let labelCoins = CGPoint.withPercent(10, y: 10)
            static let labelWorldBestScoreName = CGPoint.withPercent(68, y:12)
            static let labelWorldBestScoreValue = CGPoint.withPercent(74, y: 9.5)
        }
        
        struct zPosition {
            static let background: CGFloat = 0
            static let logo: CGFloat = 1
            
            static let coinsIndicator: CGFloat = 1
            
            static let buttonStart: CGFloat = 2
            static let buttonStore: CGFloat = 2
            static let buttonRateUs: CGFloat = 2
            static let buttonTutorial: CGFloat = 2
            static let buttonGameCenter: CGFloat = 2
            static let buttonSettings: CGFloat = 2
            
            static let labelBestScore: CGFloat = 3
            static let labelCoins: CGFloat = 3
            static let labelWorldBestScoreName: CGFloat = 3
            static let labelWorldBestScoreValue: CGFloat = 3
        }
        
        struct fontSize {
            static let labelBestScore: CGFloat = 19
            static let labelCoins: CGFloat = 19
            static let labelWorldBestScoreName: CGFloat = 17
            static let labelWorldBestScoreValue: CGFloat = 17
        }
        
        struct fontColor {
            static let labelBestScore = "#001b59"
            static let labelCoins = "#001b59"
            static let labelWorldBestScoreName = "#001b59"
            static let labelWorldBestScoreValue = "#001b59"
        }
    }
    
    //MARK: - End Scene Settings
    struct end {
        struct size {
            static let background = CGSize.withPercent(100, height: 100)
            static let logo = CGSize.withPercentScaled(100, height: 62)
            
            static let coinsIndicator = CGSize.withPercentScaled(roundByWidth: 4)
            
            static let buttonMenu = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonRestart = CGSize.withPercentScaled(roundByWidth: 13)
            static let buttonShare = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonGameCenter = CGSize.withPercentScaled(roundByWidth: 11)
        }
        
        struct position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let logo = CGPoint.withPercent(50, y: 77)
            
            static let coinsIndicator = CGPoint.withPercent(46, y: 10)
            
            static let labelScore = CGPoint.withPercent(50, y: 17)
            static let labelBestScore = CGPoint.withPercent(50, y: 14)
            static let labelCoins = CGPoint.withPercent(50, y: 10)
            
            static var buttonMenu = CGPoint.withPercent(16, y: 22)
            static var buttonRestart = CGPoint.withPercent(16, y: 30)
            static var buttonShare = CGPoint.withPercent(84, y: 22)
            static var buttonGameCenter = CGPoint.withPercent(84, y: 30)
        }
        
        struct zPosition {
            static let background: CGFloat = 0
            static let logo: CGFloat = 1
            
            static let coinsIndicator: CGFloat = 2
            
            static let labelScore: CGFloat = 3
            static let labelBestScore: CGFloat = 3
            static let labelCoins: CGFloat = 3
            
            static let buttonMenu: CGFloat = 2
            static let buttonRestart: CGFloat = 2
            static let buttonShare: CGFloat = 2
            static let buttonGameCenter: CGFloat = 2
        }
        
        struct fontSize {
            static let labelScore: CGFloat = 15
            static let labelBestScore: CGFloat = 15
            static let labelCoins: CGFloat = 19
        }
        
        struct fontColor {
            static let labelScore = "#001b59"
            static let labelBestScore = "#001b59"
            static let labelCoins = "#001b59"
        }
    }
    
    //MARK: - Settings Scene Settings
    struct settings {
        struct size {
            static let background = CGSize.withPercent(100, height: 100)
            
            static let switchSound = CGSize.withPercentScaled(16, height: 8)
            static let switchMusic = CGSize.withPercentScaled(16, height: 8)
            static let switchNotification = CGSize.withPercentScaled(16, height: 8)
            static let switchSoundDot = CGSize.withPercentScaled(6, height: 6)
            static let switchMusicDot = CGSize.withPercentScaled(6, height: 6)
            static let switchNotificationDot = CGSize.withPercentScaled(6, height: 6)
            
            static let textSettings = CGSize.withPercentScaled(40.5, height: 13.8)
            
            static let buttonBack = CGSize.withPercentScaled(roundByWidth: 11)
        }
        
        struct position {
            static let background = CGPoint.withPercent(50, y: 50)
            
            static let switchSound = CGPoint.withPercent(68, y: 58)
            static let switchMusic = CGPoint.withPercent(68, y: 50)
            static let switchNotification = CGPoint.withPercent(68, y: 42)
            static let switchDotOn = CGPoint.withPercent(4, y: 0)
            
            static let buttonBack = CGPoint.withPercent(50, y: 20)
            
            static let textSettings = CGPoint.withPercent(50, y: 86)
            
            static let labelSound = CGPoint.withPercent(57, y: 58)
            static let labelMusic = CGPoint.withPercent(57, y: 50)
            static let labelNotification = CGPoint.withPercent(57, y: 42)
        }
        
        struct zPosition {
            static let background: CGFloat = 0
            
            static let switchSound: CGFloat = 1
            static let switchMusic: CGFloat = 1
            static let switchNotification: CGFloat = 1
            static let switchDot: CGFloat = 1
            
            static let buttonBack: CGFloat = 3
            
            static let textSettings: CGFloat = 5
            
            static let labelSound: CGFloat = 2
            static let labelMusic: CGFloat = 2
            static let labelNotification: CGFloat = 2
        }
        
        struct fontSize {
            static let labelSound: CGFloat = 17
            static let labelMusic: CGFloat = 17
            static let labelNotification: CGFloat = 17
        }
        
        struct fontColor {
            static let labelSound = "#001b59"
            static let labelMusic = "#001b59"
            static let labelNotification = "#001b59"
        }
    }
    
    //MARK: - Store Scene Settings
    struct store {
        struct size {
            static let background = CGSize.withPercent(100, height: 100)
            static let buyResult = CGSize.withPercent(100, height: 100)
            
            static let coinsIndicator = CGSize.withPercentScaled(roundByWidth: 4)
            
            static let buttonBack = CGSize.withPercentScaled(11, height: 11)
            
            static let buttonSkinNext = CGSize.withPercentScaled(11, height: 11)
            static let buttonSkinPrevious = CGSize.withPercentScaled(11, height: 11)
            
            static let buttonSelector = CGSize.withPercentScaled(30, height: 13)
            
            static let buttonRemoveAds = CGSize.withPercentScaled(35, height: 10)
            static let buttonRestorePurchases = CGSize.withPercentScaled(35, height: 10)
            
            static let textStore = CGSize.withPercentScaled(28.3, height: 13.8)
        }
        
        struct position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let buyResult = CGPoint.withPercent(50, y: 50)
            
            static let coinsIndicator = CGPoint.withPercent(46, y: 79)
            
            static let buttonBack = CGPoint.withPercent(50, y: 20)
            
            static let buttonSkinNext = CGPoint.withPercent(80, y: 50)
            static let buttonSkinPrevious = CGPoint.withPercent(20, y: 50)
            static let buttonSelector = CGPoint.withPercent(50, y: 33)
            
            static let skinHolder = CGPoint.withPercent(50, y: 50)
            static let skinHolderSkinShift = SettingsGlobal.width / 100 * 23
            static let skinHolderSkinShiftNonSelectedByY = SettingsGlobal.width / 100 * 15
            
            static let buttonRemoveAds = CGPoint.withPercent(26.5, y: 10.2)
            static let buttonRestorePurchases = CGPoint.withPercent(73.5, y: 10.2)
            static let buttonRemoveAdsIfOnOnlyInApps = CGPoint.withPercent(26.5, y: 45)
            static let buttonRestorePurchasesIfOnOnlyInApps = CGPoint.withPercent(73.5, y: 45)
            
            static let textStore = CGPoint.withPercent(50, y: 86)
            
            static let labelCoins = CGPoint.withPercent(50, y: 79)
            static let labelPrice = CGPoint.withPercent(10, y: 0)
        }
        
        struct zPosition {
            static let background: CGFloat = 0
            static let buyResult: CGFloat = 10
            
            static let coinsIndicator: CGFloat = 2
            
            static let buttonBack: CGFloat = 1
            
            static let buttonSkinNext: CGFloat = 9
            static let buttonSkinPrevious: CGFloat = 9
            static let buttonSelector: CGFloat = 9
            
            static let skinHolder: CGFloat = 4
            
            static let buttonRemoveAds: CGFloat = 25
            static let buttonRestorePurchases: CGFloat = 25
            
            static let textStore: CGFloat = 10
            
            static let labelCoins: CGFloat = 3
            static let labelPrice: CGFloat = 1
        }
        
        struct fontSize {
            static let labelCoins: CGFloat = 19
            static let labelPrice: CGFloat = 32
        }
        
        struct fontColor {
            static let labelCoins = "#001b59"
            static let labelPrice = "#001b59"
        }
    }
    
    //MARK: - Tutorial Scene Settings
    struct tutorial {
        struct size {
            static let background = CGSize.withPercent(100, height: 100)
        }
        
        struct position {
            static let background = CGPoint.withPercent(50, y: 50)
        }
        
        struct zPosition {
            static let background: CGFloat = 0
        }
    }
}

private func sp_getMediaFailed() {
    print("Get User Succrss")
}
