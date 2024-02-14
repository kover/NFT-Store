//
//  ProfileRequestBody.swift
//  FakeNFT
//
//  Created by Avtor_103 on 01.02.2024.
//

import Foundation

struct ProfileRequestBody: Encodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let likes: [String]
}
