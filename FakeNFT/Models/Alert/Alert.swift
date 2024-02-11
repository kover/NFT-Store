//
//  Alert.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 28.01.2024.
//

import Foundation

struct Alert {
    let title: String
    let message: String
    let actionTitle: String
    let completion: () -> Void
}
