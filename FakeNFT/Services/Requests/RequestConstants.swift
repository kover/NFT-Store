import UIKit

enum RequestConstants {
    static let baseURL = "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net"

    case collections
    case nftById(id: String)

    var path: String {
        switch self {
        case .collections:
            return "api/v1/collections"
        case .nftById(let id):
            return "api/v1/nft/\(id)"
        }
    }

    var url: URL? {
        switch self {
        case .collections:
            return URL(string: RequestConstants.collections.path, relativeTo: URL(string: RequestConstants.baseURL))
        case .nftById(let id):
            return URL(string: RequestConstants.nftById(id: id).path, relativeTo: URL(string: RequestConstants.baseURL))
        }
    }
}
