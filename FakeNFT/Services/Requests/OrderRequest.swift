//
//  OrderRequest.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 28.01.2024.
//

import Foundation

struct OrderRequest: NetworkRequest {
    var endpoint: URL? { RequestConstants.order.url }
    var httpMethod: HttpMethod { .get }
}
