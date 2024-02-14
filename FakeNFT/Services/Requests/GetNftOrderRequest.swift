//
//  GetNftOrder.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 27.01.2024.
//

import Foundation

struct GetNftOrderRequest: NetworkRequest {

    var endpoint: URL? {
        RequestConstants.order.url
    }

    var httpMethod: HttpMethod {
        .get
    }
}
