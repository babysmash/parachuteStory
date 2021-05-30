//
//  NSObject+Additions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

private func sp_getUserName() {
    print("Get Info Failed")
}
