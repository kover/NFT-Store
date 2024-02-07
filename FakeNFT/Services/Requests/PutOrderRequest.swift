//
//  PutOrderRequest.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 28.01.2024.
//

import Foundation

struct PutOrderRequest: NetworkRequest {
    let model: Order
    var endpoint: URL? {
        RequestConstants.order.url
    }
    var httpMethod: HttpMethod { .put }

    var query: [URLQueryItem]? {
        model.nfts.map { nft in
            URLQueryItem(name: "nfts", value: nft)
        }
    }

    init(order: Order) {
        self.model = order
    }
}
