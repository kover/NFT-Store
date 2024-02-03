//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 19.01.2024.
//

import Foundation

struct ProfileModel: Equatable {
    let avatarUrl: URL?
    let name: String
    let description: String
    let link: String
    let myNtfIds: [String]
    let favoritesNtsIds: [String]
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.avatarUrl == rhs.avatarUrl &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.link == rhs.link &&
        lhs.myNtfIds == rhs.myNtfIds &&
        lhs.favoritesNtsIds == rhs.favoritesNtsIds
    }
}
