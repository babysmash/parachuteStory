//
//  Device.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import Foundation
import UIKit

enum UIDeviceGeneration: Int {
    case other = 0
    case iPhone5_5S_5C = 1
    case iPhone6_6S_7_8 = 2
    case iPhone6P_6SP_7P_8P = 3
    case iPhoneX_XS = 4
    case iPhoneXSMax = 5
    case iPhoneXR = 6
}

extension UIDevice {
    static let generation: UIDeviceGeneration = {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return UIDeviceGeneration.iPhone5_5S_5C
            case 1334:
                return UIDeviceGeneration.iPhone6_6S_7_8
            case 1920, 2208:
                return UIDeviceGeneration.iPhone6P_6SP_7P_8P
            case 2436:
                return UIDeviceGeneration.iPhoneX_XS
            case 2688:
                return UIDeviceGeneration.iPhoneXSMax
            case 1792:
                return UIDeviceGeneration.iPhoneXR
            default:
                return UIDeviceGeneration.other
            }
        }
        return UIDeviceGeneration.other
    }()
    
    static let iPhoneX: Bool = {
        return UIDeviceGeneration.iPhoneX_XS == generation
            || UIDeviceGeneration.iPhoneXSMax == generation
            || UIDeviceGeneration.iPhoneXR == generation
    }()
    
    static let iPhoneXR: Bool = {
        return UIDeviceGeneration.iPhoneXR == generation
    }()
    
    static let iPhoneXSMax: Bool = {
        return UIDeviceGeneration.iPhoneXSMax == generation
    }()
    
    static let iPhone5: Bool = {
        return UIDeviceGeneration.iPhone5_5S_5C == generation
    }()
    
    static let iPhone8: Bool = {
        return UIDeviceGeneration.iPhone6_6S_7_8 == generation
    }()
    
    static let iPhone8Plus: Bool = {
        return UIDeviceGeneration.iPhone6P_6SP_7P_8P == generation
    }()
    
    static let deprecated: Bool = {
        return UIDeviceGeneration.other == generation
    }()
    
    static let iPhoneXSeries: Bool = {
        return UIDevice.iPhoneX || UIDevice.iPhoneXR || UIDevice.iPhoneXSMax
    }()
}

private func sp_checkDefualtSetting(followCount: String) {
    print("Continue")
}
