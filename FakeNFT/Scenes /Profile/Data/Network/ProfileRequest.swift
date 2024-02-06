//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Avtor_103 on 01.02.2024.
//

import Foundation

final class ProfileRequest: NetworkRequest {
    
    private let requestBody: ProfileRequestBody?
    
    private let _httpMethod: HttpMethod
    
    var endpoint: URL? {
        URL(string: RequestConstants.baseURL + RequestConstants.profilePath)
    }
    
    var httpMethod: HttpMethod { _httpMethod }
    
    var query: [URLQueryItem]? {
        guard let requestBody else { return nil }
        var urlQueryItem = [
            URLQueryItem(name: "name", value: requestBody.name),
            URLQueryItem(name: "avatar", value: requestBody.avatar),
            URLQueryItem(name: "description", value: requestBody.description),
            URLQueryItem(name: "website", value: requestBody.website)
        ]

        let likesUrlQueryItem = requestBody.likes.map { URLQueryItem(name: "likes", value: $0) }

        urlQueryItem.append(contentsOf: likesUrlQueryItem)

        return urlQueryItem
    }

    init(
        requestBody: ProfileRequestBody? = nil,
        httpMethod: HttpMethod
    ) {
        self._httpMethod = httpMethod
        self.requestBody = requestBody
    }
}
