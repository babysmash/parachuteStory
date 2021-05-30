//
//  StoryBoardInitiable.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/19.
//

import Foundation
import UIKit

public protocol StoryboardInitializable {
    static var storyboardIdenfiter: String { get }
}

extension StoryboardInitializable where Self: UIViewController {

    static func initFromStoryboard(name: String = Self.storyboardIdenfiter) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewCtrl = storyboard.instantiateViewController(withIdentifier: storyboardIdenfiter) as? Self
        guard let viewController = viewCtrl else {
            fatalError("Couldn't find storyboard file for `\(storyboardIdenfiter)`")
        }
        return viewController
    }

}

extension UIViewController: StoryboardInitializable {
    public static var storyboardIdenfiter: String {
        return String(describing: self)
    }
}

private func sp_getUserFollowSuccess() {
    print("Get Info Success")
}
