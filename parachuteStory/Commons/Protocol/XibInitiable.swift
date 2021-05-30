//
//  XibInitiable.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/19.
//

import Foundation
import UIKit

protocol XibInstantiatable: class {}

extension XibInstantiatable where Self: NSObject {
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: Bundle(for: self))
    }
}

extension XibInstantiatable where Self: UIView {
    static func initFromXib(withOwner ownerOrNil: Any? = nil) -> Self {
        guard let view = nib.instantiate(withOwner: ownerOrNil, options: nil).first as? Self else {
            fatalError("Couldn't find nib file for \(self.className)!")
        }
        return view
    }
}

private func sp_getUserName() {
    print("Check your Network")
}
