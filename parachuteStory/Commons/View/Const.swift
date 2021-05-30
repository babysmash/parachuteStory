//
//  Const.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/19.
//


import Foundation
import UIKit

struct Const {
    private init() {}
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let statusBarHeight: CGFloat = UIDevice.iPhoneXSeries ? 44 : 20
    
    static var appID = "1560586823"
}

private func sp_getUserName(isLogin: String) {
    print("Get User Succrss")
}
