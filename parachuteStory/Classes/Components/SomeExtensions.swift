//
//  SomeExtensions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/15.
//

import Foundation
import SpriteKit

//MARK: - Object extentions
@available(iOS 10, *)
public extension SKTexture {
    
    /**
     Create texture object considerate filtration settigns.
     
     Use for considerate filtration setting in game. You can change it settings in SettingsGlobal.swift. Find filteredImagesInGame value in WorkWithScenes struct.
     
     - property imageName: You image name in String format.
     */
    convenience init(сonsideringFiltrationSettingsInProject imageName: String) {
        self.init(imageNamed: imageName)
        if !SettingsGlobal.WorkWithScenes.filteredImagesInGame {
            filteringMode = .nearest
        }
    }
}

public extension UIColor {
    
    /**
     Create UIColor object from hex value.
     
     - property hexString: It string with you color name in hex. It been look like it "#ffffff".
     */
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        
        //Decode hex
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        
        //Create UIColoe
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//MARK: Animation

public extension SKAction {
    
    /**
     Same function like standart SKAction, but here we can use degrees for setup rotate destination.
     */
    static func rotateByDegree(_ degree: CGFloat, duration: TimeInterval) -> SKAction {
        return SKAction.rotate(byAngle: CGFloat(degreeToRadian: degree), duration: duration)
    }
    
    /**
     Same function like standart SKAction, but here we can use degrees for setup rotate destination.
     */
    static func rotateToDegree(_ degree: CGFloat, duration: TimeInterval) -> SKAction {
        return SKAction.rotate(toAngle: CGFloat(degreeToRadian: degree), duration: duration)
    }
    
    /**
     Same function like standart SKAction, but here we can use degrees for setup rotate destination.
     */
    static func rotateToDegree(_ degree: CGFloat, duration: TimeInterval, shortestUnitArc: Bool) -> SKAction {
        return SKAction.rotate(toAngle: CGFloat(degreeToRadian: degree), duration: duration, shortestUnitArc: shortestUnitArc)
    }
}

//MARK: Sizes and positions

public extension CGSize {
    
    /**
     Init size form percent size of scene.
     */
    static func withPercent(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.width) / 100 * width, height: CGFloat(SettingsGlobal.height) / 100 * height)
    }
    
    /**
     Init size form percent size of scene. In this init height scaled by widht. Use this for make size with an equal aspect ratio on different screen sizes.
     */
    static func withPercentScaled(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.width) / 100 * width, height: CGFloat(SettingsGlobal.width) / 100 * height)
    }
    
    /**
     Init size form percent size of scene. In this init height scaled by widht. Use this for calling simmilar height and width size.
     */
    static func withPercentScaled(roundByWidth width: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.width) / 100 * width, height: CGFloat(SettingsGlobal.width) / 100 * width)
    }
    
    /**
     Init size form percent size of scene. In this init height scaled by height. Use this for calling simmilar height and width size.
     */
    static func withPercentScaled(roundByHeight height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.height) / 100 * height, height: CGFloat(SettingsGlobal.height) / 100 * height)
    }
}

public extension CGPoint {
    
    /**
     Init position from percent of screen size
     */
    static func withPercent(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat(SettingsGlobal.width) / 100 * x, y: CGFloat(SettingsGlobal.height) / 100 * y)
    }
}

//MARK: - SKSpriteNode

public extension SKSpriteNode {
    
    func new(positionByX x: CGFloat) { self.position = CGPoint(x: x, y: position.y)}
    func new(positionByY y: CGFloat) { self.position = CGPoint(x: position.x, y: y)}
}

//MARK: - Value extentions

//Shuffle array

extension Array {
    /**
     Use this for shuffle arrays
     */
    mutating func shuffle() {
        for _ in 0..<10 { sort { (_,_) in arc4random() < arc4random() }}
    }
}

//Randoms

public extension Bool {
    /**
     Get random bool value
     */
    static func random() -> Bool {
        return Int(from: 1, to: 2) == 1 ? true : false
    }
}

public extension Int {
    init(from: Int, to: Int) {
        self = from < to ?
            Int(arc4random_uniform(UInt32(to - from + 1))) + from :
            Int(arc4random_uniform(UInt32(from - to + 1))) + to
    }
    
    //Random from zero to value
    init(fromZeroTo value: Int) { self = Int(from: 0, to: value)}
    init(fromZeroTo value: Float) { self = Int(from: 0, to: Int(value))}
    init(fromZeroTo value: Double) { self = Int(from: 0, to: Int(value))}
    init(fromZeroTo value: CGFloat) { self = Int(from: 0, to: Int(value))}
    //Convert degrees to radian
    init(degreeToRadian degree: Int) { self = Int(Double(degree) * Double.pi / 180.0)}
    init(degreeToRadian degree: Float) { self = Int(Double(degree) * Double.pi / 180.0)}
    init(degreeToRadian degree: Double) { self = Int(Double(degree) * Double.pi / 180.0)}
    init(degreeToRadian degree: CGFloat) { self = Int(Double(degree) * Double.pi / 180.0)}
    //Convert radian to degrees
    init(radianToDegree radian: Int) { self = Int(Double(radian) * 180.0 / Double.pi)}
    init(radianToDegree radian: Float) { self = Int(Double(radian) * 180.0 / Double.pi)}
    init(radianToDegree radian: Double) { self = Int(Double(radian) * 180.0 / Double.pi)}
    init(radianToDegree radian: CGFloat) { self = Int(Double(radian) * 180.0 / Double.pi)}
}

public extension Double {
    
    init(from: Double, to: Double) {
        self = from < to ?
            (Double(arc4random()) / Double(UInt32.max)) * (to - from) + from :
            (Double(arc4random()) / Double(UInt32.max)) * (from - to) + to
    }
    
    //Random from zero to value
    init(fromZeroTo value: Double) { self = Double(from: 0, to: value)}
    init(fromZeroTo value: Int) { self = Double(from: 0, to: Double(value))}
    init(fromZeroTo value: Float) { self = Double(from: 0, to: Double(value))}
    init(fromZeroTo value: CGFloat) { self = Double(from: 0, to: Double(value))}
    //Convert degrees to radian
    init(degreeToRadian degree: Double) { self = degree * Double.pi / 180.0}
    init(degreeToRadian degree: Int) { self = Double(degree) * Double.pi / 180.0}
    init(degreeToRadian degree: Float) { self = Double(degree) * Double.pi / 180.0}
    init(degreeToRadian degree: CGFloat) { self = Double(degree) * Double.pi / 180.0}
    //Convert radian to degrees
    init(radianToDegrees radian: Double) { self = radian * 180.0 / Double.pi}
    init(radianToDegrees radian: Int) { self = Double(radian) * 180.0 / Double.pi}
    init(radianToDegrees radian: Float) { self = Double(radian) * 180.0 / Double.pi}
    init(radianToDegrees radian: CGFloat) { self = Double(radian) * 180.0 / Double.pi}
}

public extension Float {
    
    init(from: Float, to: Float) {
        self = from < to ?
            (Float(arc4random()) / Float(UInt32.max)) * (to - from) + from :
            (Float(arc4random()) / Float(UInt32.max)) * (from - to) + to
    }
    
    //Random from zero to value
    init(fromZeroTo value: Float) { self = Float(from: 0, to: value)}
    init(fromZeroTo value: Int) { self = Float(from: 0, to: Float(value))}
    init(fromZeroTo value: Double) { self = Float(from: 0, to: Float(value))}
    init(fromZeroTo value: CGFloat) { self = Float(from: 0, to: Float(value))}
    //Convert degrees to radian
    init(degreeToRadian degree: Float) { self = degree * Float.pi / 180.0}
    init(degreeToRadian degree: Int) { self = Float(degree) * Float.pi / 180.0}
    init(degreeToRadian degree: Double) { self = Float(degree) * Float.pi / 180.0}
    init(degreeToRadian degree: CGFloat) { self = Float(degree) * Float.pi / 180.0}
    //Convert radian to degrees
    init(radianToDegrees radian: Float) { self = radian * 180.0 / Float.pi}
    init(radianToDegrees radian: Int) { self = Float(radian) * 180.0 / Float.pi}
    init(radianToDegrees radian: Double) { self = Float(radian) * 180.0 / Float.pi}
    init(radianToDegrees radian: CGFloat) { self = Float(radian) * 180.0 / Float.pi}
}

public extension CGFloat {
    
    init(from: CGFloat, to: CGFloat) {
        self = from < to ?
            (CGFloat(arc4random()) / CGFloat(UInt32.max)) * (to - from) + from :
            (CGFloat(arc4random()) / CGFloat(UInt32.max)) * (from - to) + to
    }
    
    //Random from zero to value
    init(fromZeroTo value: CGFloat) { self = CGFloat(from: 0, to: value)}
    init(fromZeroTo value: Double) { self = CGFloat(from: 0, to: CGFloat(value))}
    init(fromZeroTo value: Int) { self = CGFloat(from: 0, to: CGFloat(value))}
    init(fromZeroTo value: Float) { self = CGFloat(from: 0, to: CGFloat(value))}
    //Convert degrees to radian
    init(degreeToRadian degree: CGFloat) { self = degree * CGFloat.pi / 180.0}
    init(degreeToRadian degree: Double) { self = CGFloat(degree) * CGFloat.pi / 180.0}
    init(degreeToRadian degree: Int) { self = CGFloat(degree) * CGFloat.pi / 180.0}
    init(degreeToRadian degree: Float) { self = CGFloat(degree) * CGFloat.pi / 180.0}
    //Convert radian to degrees
    init(radianToDegrees radian: CGFloat) { self = radian * 180.0 / CGFloat.pi}
    init(radianToDegrees radian: Double) { self = CGFloat(radian) * 180.0 / CGFloat.pi}
    init(radianToDegrees radian: Int) { self = CGFloat(radian) * 180.0 / CGFloat.pi}
    init(radianToDegrees radian: Float) { self = CGFloat(radian) * 180.0 / CGFloat.pi}
}


private func sp_getUsersMostLikedSuccess() {
    print("Get Info Failed")
}
