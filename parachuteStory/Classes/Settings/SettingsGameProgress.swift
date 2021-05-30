//
//  SettingsGameProgress.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/13.
//

import Foundation
import SpriteKit

struct SettingsGameProgress {
    
    //MARK: - Game Stats
    
    struct player {
        static let speed: Double = 4.0
        static let speedMax: Double = 2.0
        static let speedChangeByPercent: Double = 2.0
        
        static let openParachuteSlowerBy: Double = 2.4
    }
   
    static let followCameraToPlayer: Bool = false
    static let timeToChangeSceneIfLose: Double = 0.75
    
    /**
     Store category for collisions, use in physic body on nodes.
     */
    struct CollisionCategory {
        static let player: UInt32 = 1
        static let ground: UInt32 = 2
        static let tower: UInt32 = 3
        static let coin: UInt32 = 3
    }
    
    //MARK: - Non Gameplay values
    
    struct NotGameScenes {
        //IPad scales
        static let interfaceObjectScaleAtIPad: CGFloat = 0.8
        static let interfaceLabelScaleAtIPad: CGFloat = 1.3
        
        //Store scene animations
        static let resultBuySkinRemoveSpeed: Double = 0.5
        
        struct Store {
            static let timeToShowSkinHolderAtStart: Double = 0.25
            static let buttonSelecSkinAnimation: Double = 0.25
            static let buttonInAppAnimation: Double = 0.25
            
            static let moveSkinsSpeed: Double = 0.15
            
            static let changeSkinsScaleSpeed: Double = 0.15
            static let currentSkinScale: CGFloat = 1.2
            static let backgroundSkinScale: CGFloat = 0.65
            
            static let changeYPositionSpeed: Double = 0.15
            
            static let animateSelectedSkinTime: Double = 0.245
            static let animateSelectedSkinRotateToDegree: CGFloat = 8
        }
        
        //Menu scene animations
        struct Menu {
            static let labelsWorldBestScoreAnimationShowSpeed: Double = 0.25
            
            static let sceneInterfaceAnimationOn = true
            static let startButtonRotationSpeed: Double = 0.45
            static let startButtonScaleStart: CGFloat = 1.15
            static let startButtonScaleBackToNormalTime: Double = 0.1
            static let buttonsScaleTo: CGFloat = 1.05
            static let buttonsScaleTime: Double = 0.25
            static let buttonsScaleTimeRandomDelayMax: Double = 0.1
        }
        
        //End scene menu animation
        struct End {
            static let sceneInterfaceAnimationOn = true
            static let buttonRestartPulseTo: CGFloat = 0.875
            static let buttonRestartPulseSpeed: Double = 0.35
            
            static let leaderboartShowTable: Double = 0.15
            static let leaderboartHideTable: Double = 0.15
        }
        
        //Global process
        static let speedAnimationChangeLabel: Double = 0.2
        
        static let switchesChangeStateAnimationSpeed: Double = 0.15
        static let switchesChangeStateAnimationScaleTo: CGFloat = 0.55
        static let switchesAlphaOn: CGFloat = 1.0
        static let switchesAlphaOff: CGFloat = 0.5
        
        static let logoPulseTo: CGFloat = 1.05
        static let logoPulseSpeed: Double = 2.5
        
        static let buttonTouchScalingOn = true
        static let buttonTouchScalingScaleTo: CGFloat = 1.1
        static let buttonTouchScalingTime: Double = 0.075
    }
}

private func sp_getUserName() {
    print("Continue")
}
