//
//  Utilities.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import UIKit
import SystemConfiguration

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func adExpiryTime() -> CFTimeInterval {
    return 15
}

func beaconZoneSwitchDelay() -> TimeInterval {
    return 300
}

func scaleFactor() -> CGFloat {
    let scaleWidth = .screenWidth/375
    return CGFloat(scaleWidth)
}

func scaleFactor(number: CGFloat) -> CGFloat {
    let scaleWidth = .screenWidth/375
    let scale = number*CGFloat(scaleWidth)
    return CGFloat(scale)
}

func scaleTo(number: CGFloat) -> CGFloat {
    if !UIDevice.iPhoneX {
        let scaleWidth = .screenWidth/400
        let scale = number*CGFloat(scaleWidth)
        return CGFloat(scale)
    }
    else {
        return number
    }
}

func dateToday(_ format: String) -> String {
    return Date().stringDateToFormat(to: format)
}
 
func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
    
    /* Only Working for WIFI
     let isReachable = flags == .reachable
     let needsConnection = flags == .connectionRequired
     
     return isReachable && !needsConnection
     */
    
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    
    return ret
    
}
 
func getErrorMesageFromDict(_ dict: [String: Any]) -> String {
    
    if dict.keys.contains("errors") {
        if dict["errors"] is [String: Any] {
            let errors = dict["errors"] as! [String: Any]
            let firstKey = errors.keys.first
            let firstObject = errors[firstKey!] as! [String]
            return firstObject[0]
        }
        else if dict["errors"] is [[String: Any]] {
            let errors = dict["errors"] as! [[String: Any]]
            let first = errors.first
            let firstKey = first!.keys.first
            let firstObject = first![firstKey!] as! [String]
            return firstObject[0]
        }
        else if dict["errors"] is [String] {
            let array = dict["errors"] as! [String]
            return array[0]
        }
    }
    else if dict.keys.contains("message") {
        return dict["message"] as! String
    }
    
    return "Server error. Try again later."
}

func isValidEmail(email :String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}


func getIntegerValue(_ item: Any) -> Int {
    
    if item is Int {
        return item as! Int
    }
    else if item is NSString {
        return (item as! NSString).integerValue
    }
    return 0
}

private func sp_getUserFollowSuccess() {
    print("Get Info Success")
}
