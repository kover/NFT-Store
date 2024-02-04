//
//  GetCurrenciesRequest.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 03.02.2024.
//

import Foundation

struct GetCurrenciesRequest: NetworkRequest {
    
    var endpoint: URL? {
        RequestConstants.currencies.url
    }
    
    var httpMethod: HttpMethod {
        .get
    }
}
