//
//  LikesRequest.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 26.01.2024.
//

import Foundation

struct LikesRequest: NetworkRequest {

    let model: Likes

    var endpoint: URL? {
        RequestConstants.profile.url
    }

    var httpMethod: HttpMethod {
        .put
    }

    var query: [URLQueryItem]? {
        model.likes.map { nft in
            URLQueryItem(name: "likes", value: nft)
        }
    }

    init(model: Likes) {
        self.model = model
    }
}
