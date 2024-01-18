//
//  NftModel.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import Foundation

struct NftModel: Decodable {
    let id: String
    let name: String
    let images: [String]
    let price: Double
    let rating: Int
}

