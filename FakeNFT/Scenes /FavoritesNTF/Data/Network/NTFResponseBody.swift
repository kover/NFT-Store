//
//  NTFResponseBody.swift
//  FakeNFT
//
//  Created by Avtor_103 on 06.02.2024.
//

import Foundation

struct NTFResponseBody: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
