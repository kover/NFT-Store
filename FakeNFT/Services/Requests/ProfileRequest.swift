//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 26.01.2024.
//

import Foundation

struct ProfileRequest: NetworkRequest {

    var endpoint: URL? {
        RequestConstants.profile.url
    }

    var httpMethod: HttpMethod {
        .get
    }

}
