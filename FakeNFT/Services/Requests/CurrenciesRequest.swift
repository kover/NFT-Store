//
//  CurrenciesRequest.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 30.01.2024.
//

import Foundation

struct CurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        RequestConstants.currencies.url
    }
    var httpMethod: HttpMethod {
        .get
    }
}
