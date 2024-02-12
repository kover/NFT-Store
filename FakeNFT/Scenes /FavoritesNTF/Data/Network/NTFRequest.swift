//
//  NTFRequest.swift
//  FakeNFT
//
//  Created by Avtor_103 on 06.02.2024.
//

import Foundation

final class NTFRequest: NetworkRequest {
    
    private let id: String
    
    var endpoint: URL? {
        RequestConstants.nftById(id: id).url
    }
    
    var httpMethod: HttpMethod { .get }
    
    init(id: String) {
        self.id = id
    }
}
