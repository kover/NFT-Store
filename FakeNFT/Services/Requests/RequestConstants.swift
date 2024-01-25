import UIKit

enum RequestConstants {
    static let baseURL = ApiConstants.baseUrl.rawValue

    case collections
    case nftById(id: String)
    case userById(id: String)

    var url: URL? {
        switch self {
        case .collections:
            return URL(string: "api/v1/collections", relativeTo: URL(string: RequestConstants.baseURL))
        case .nftById(let id):
            return URL(string: "api/v1/nft/\(id)", relativeTo: URL(string: RequestConstants.baseURL))
        case .userById(let id):
            return URL(
                string: "api/v1/users/\(id)",
                relativeTo: URL(string: RequestConstants.baseURL)
            )
        }
    }
}
