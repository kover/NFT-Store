//
//  PaymentResponse.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 03.02.2024.
//

import Foundation

struct PaymentResponse: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
