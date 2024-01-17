//
//  NftCollection.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 12.01.2024.
//

import Foundation

struct NftCollection: Codable {
    let createdAt: Date
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
    let id: String
}
