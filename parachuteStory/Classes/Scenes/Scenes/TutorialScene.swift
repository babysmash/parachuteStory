//
//  TutorialScene.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

class TutorialScene: GlobalScene {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    
    //MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
        addChild(background)
    }
    
    fileprivate func closeTutorial() {
        //If it's scene been show after pressed to start game at first change scene to game scene.
        if UserDefaults.standard.bool(forKey: "_pressToStart") {
            UserDefaults.standard.set(false, forKey: "_pressToStart")
            changeSceneTo(.game, withTransitionName: .pushLeft)
        }
        else {
            changeSceneTo(.menu, withTransitionName: .pushRight)
        }
    }
    
    //MARK: - Input
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeTutorial()
        Sound.sharedInstance().playSound(Sound.name.buttonPress)
    }
}

private func sp_checkNetWorking() {
    print("Get Info Success")
}
