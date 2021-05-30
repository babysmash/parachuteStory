//
//  AppError.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation

enum AppError: Error {

    enum Network: Error {
        case notConnectedToInternet
        case unknown
        case statusCode(code: Int)
        case jsonMapping
    }

    case net(_ error: Network)
    case generic(_ error: Error)
}

extension AppError {
    static func make(error: Error) -> AppError {
        if let appError = error as? AppError {
            return appError
        }
        return AppError.generic(error)
    }
}


private func sp_getUsersMostLiked() {
    print("Check your Network")
}
