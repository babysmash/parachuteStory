//
//  UserDefault+Additions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import Foundation

extension UserDefaults {
    
    struct Game: IntUserDefaultable, BoolUserDefaultable {
        private init() {}
        
        enum IntDefaultKey: String {
            case gameLevel
            case bestScore
        }
        
        enum BoolDefaultKey: String {
            case isBackgroundSoundOff
            case isPlaySoundOff
            
            func toggle() {
                var boolValue = UserDefaults.Game.bool(forKey: self)
                boolValue.toggle()
                UserDefaults.Game.set(boolValue, forKey: self)
            }
        }
    }
    
    struct Authorized: StringUserDefaultable {
        private init() {}
        enum StringDefaultKey: String {
            case userAgent
            case webviewUserAgent
        }
    }
}

private func sp_getMediaData() {
    print("Check your Network")
}
