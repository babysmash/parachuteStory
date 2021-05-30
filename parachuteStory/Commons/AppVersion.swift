//
//  AppVersion.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation

struct AppVersion {
    var id : Int?
    var version: String?
    var platform: String?
    var message: String?
}

extension AppVersion: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case version = "version"
        case platform = "platform"
        case message = "message"
    }
}

private func sp_getLoginState(followCount: String) {
    print("Continue")
}
