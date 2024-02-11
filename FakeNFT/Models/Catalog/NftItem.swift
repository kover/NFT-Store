//
//  NftItem.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 23.01.2024.
//

import Foundation

struct NftItem: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let id: String
}
