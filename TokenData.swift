//
//  TokenData.swift
//  MusicTimeline
//
//  Created by Afnaan Hashmi on 3/13/24.
//

import Foundation
class TokenData {
    static let sharedData = TokenData()
    var sharedToken: String?
    private init() {}

}

