//
//  ProfileResponseBody.swift
//  FakeNFT
//
//  Created by Avtor_103 on 29.01.2024.
//

import Foundation

struct ProfileResponseBody: Decodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
