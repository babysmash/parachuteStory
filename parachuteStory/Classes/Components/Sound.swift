//
//  Sound.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit
import AVFoundation

private let SoundInstance = Sound()

open class Sound {
    
    open class func sharedInstance() -> Sound { return SoundInstance}
    
    //MARK: - Sounds
    open var sceneForPlayingSounds: SKScene?
    
    /**
     Enum with list of possible sounds.
     */
    public enum name {
        case buttonPress
        case tumblerClick
        case getPoint
        case getCoin
        case smash1
        case smash2
    }
    
    //Preloaded sounds action for scene
    internal let buttonPress = SKAction.playSoundFileNamed("buttonPress.mp3", waitForCompletion: false)
    internal let tumblerClick = SKAction.playSoundFileNamed("tumblerClick.mp3", waitForCompletion: false)
    internal let getPoint = SKAction.playSoundFileNamed("Ka-Ching.wav", waitForCompletion: false)
    internal let getCoin = SKAction.playSoundFileNamed("getCoin.mp3", waitForCompletion: false)
    internal let smash1 = SKAction.playSoundFileNamed("manScrim.mp3", waitForCompletion: false)
    internal let smash2 = SKAction.playSoundFileNamed("manScrim.mp3", waitForCompletion: false)
    
    /**
     It's interface for playing sounds.
     */
    open func playSound(_ name: name) {
        if UserDefaults.standard.bool(forKey: "PlaySounds") {
            switch name {
            case .buttonPress:
                sceneForPlayingSounds?.run(Sound.sharedInstance().buttonPress)
            case .tumblerClick:
                sceneForPlayingSounds?.run(Sound.sharedInstance().tumblerClick)
            case .getPoint:
                sceneForPlayingSounds?.run(Sound.sharedInstance().getPoint)
            case .getCoin:
                sceneForPlayingSounds?.run(Sound.sharedInstance().getCoin)
            case .smash1:
                sceneForPlayingSounds?.run(Sound.sharedInstance().smash1)
            case .smash2:
                sceneForPlayingSounds?.run(Sound.sharedInstance().smash2)
            }
        }
        else { Debugger.printNow("Sound class: Class not have output object for playing sound")}
    }
    
    /**
     Change settings of sounds. Possible to play or not
     */
    open func changeSoundState() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlaySounds"), forKey: "PlaySounds")
    }
    
    //MARK: - Music
    fileprivate var musicPlayer: AVAudioPlayer?
    
    /**
     Create music and play it if it's possible by settings.
     
     Better for use in launch game part of app.
     */
    open func playMusic() {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "GameBG.mp3", withExtension: nil)!)
            musicPlayer!.numberOfLoops = -1
            musicPlayer!.prepareToPlay()
            if UserDefaults.standard.bool(forKey: "PlayMusic") {
                musicPlayer!.play()
            }
        } catch { Debugger.printNow("Sound class: Not can create AVAudioPlayer for music")}
    }
    
    func pauseMusic() {
        if musicPlayer!.isPlaying { musicPlayer!.pause()}
    }
    
    func resumeMusic() {
        if !musicPlayer!.isPlaying { musicPlayer!.play()}
    }
    
    /**
     Change playing setting for music.
     
     If you change settings it's function make pause or contine to play music.
     */
    open func changeMusicState() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlayMusic"), forKey: "PlayMusic")
        
        if UserDefaults.standard.bool(forKey: "PlayMusic") { resumeMusic()}
        else { pauseMusic()}
    }
}


private func sp_upload() {
    print("Get Info Success")
}
