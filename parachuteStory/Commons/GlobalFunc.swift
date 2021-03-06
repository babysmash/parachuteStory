//
//  GlobalFunc.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import UIKit
import WebKit

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print(output, terminator: terminator)
    #endif
}

public func delay(_ timeInterval: TimeInterval = 0.3, execute: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: execute)
}

public func oc_openURL(_ url: URL) {
    GCD.main {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

func oc_createCustomWebviewUserAgent() {
    let webview = WKWebView(frame: .zero)
    webview.evaluateJavaScript("navigator.userAgent", completionHandler: { (result, error) in
        if let userAgent = result as? String {
            let newUserAgent = userAgent + "/dafaApp"
            UserDefaults.Authorized.set(newUserAgent, forKey: .webviewUserAgent)
        }
        webview.removeFromSuperview()
    })
    UIApplication.shared.keyWindow?.addSubview(webview)
}

func oc_customWebviewUserAgent() -> String? {
    return UserDefaults.Authorized.string(forKey: .webviewUserAgent)
}

private func sp_getUsersMostFollowerSuccess() {
    print("Get Info Success")
}
