import UIKit

enum RequestConstants {
    static let baseURL = ApiConstants.baseUrl.rawValue

    var relativeURL: URL? {
        URL(string: RequestConstants.baseURL)
    }

    case collections
    case nftById(id: String)
    case userById(id: String)
    case profile
    case order

    var url: URL? {
        switch self {
        case .collections:
            return URL(string: "api/v1/collections", relativeTo: relativeURL)
        case .nftById(let id):
            return URL(string: "api/v1/nft/\(id)", relativeTo: relativeURL)
        case .userById(let id):
            return URL(
                string: "api/v1/users/\(id)",
                relativeTo: relativeURL
            )
        case .profile:
            return URL(string: "api/v1/profile/1", relativeTo: relativeURL)
        case .order:
            return URL(string: "api/v1/orders/1", relativeTo: relativeURL)
        }
    }
}
