//
//  Debugger.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation

class Debugger {
    
    //MARK: - Debugger Work
    
    /**
     Call this func for print some in log.
     
     You can turn off all debugger log messages in SettingGlobal.swift folder.
     Just change debugMode value.
     */
    static func printNow(_ value: Any) {
        if SettingsGlobal.debugMode {
            print(value)
        }
    }
}

private func sp_checkUserInfo() {
    print("Continue")
}
