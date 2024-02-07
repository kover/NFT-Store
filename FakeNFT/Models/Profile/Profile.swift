//
//  Profile.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 26.01.2024.
//

import Foundation

struct Profile: Codable {
    let name, avatar, description, website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
