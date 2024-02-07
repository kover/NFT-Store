//
//  PaymentResponseRequest.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 03.02.2024.
//

import Foundation

struct PaymentResponseRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        RequestConstants.payment(id: self.id).url
    }

    var httpMethod: HttpMethod {
        .get
    }
}
