//
//  PutNftOrderRequest.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 30.01.2024.
//

import Foundation

struct PutOrderRequest: NetworkRequest {
    let model: OrderModel
    var endpoint: URL? {
        RequestConstants.order.url
    }
    var httpMethod: HttpMethod { .put }

    var query: [URLQueryItem]? {
        model.nfts.map { nft in
            URLQueryItem(name: "nfts", value: nft)
        }
    }

    init(order: OrderModel) {
        self.model = order
    }
}
