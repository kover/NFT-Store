//
//  CollectionsRequest.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 17.01.2024.
//

import Foundation

struct CollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        RequestConstants.collections.url
    }
    var httpMethod: HttpMethod {
        .get
    }
}
