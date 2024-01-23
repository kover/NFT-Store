//
//  NftModel.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import Foundation

struct NftModel: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}

