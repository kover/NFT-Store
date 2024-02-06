import UIKit

enum RequestConstants {
    static let baseURL = "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net/"
    
    case collections
    case order
    case nftById(id: String)
    case userById(id: String)
    case currencies
    case payment(id: String)
    
    var path: String {
        switch self {
        case .collections:
            return "api/v1/collections"
        case .nftById(let id):
            return "api/v1/nft/\(id)"
        case .userById(let id):
            return "api/v1/users/\(id)"
        case .order:
            return "/api/v1/orders/1"
        case .currencies:
            return "/api/v1/currencies"
        case .payment(let id):
            return "/api/v1/orders/1/payment/\(id)"
        }
    }
    
    var url: URL? {
        switch self {
        case .collections:
            return URL(string: RequestConstants.collections.path, 
                       relativeTo: URL(string: RequestConstants.baseURL))
        case .nftById(let id):
            return URL(string: RequestConstants.nftById(id: id).path, 
                       relativeTo: URL(string: RequestConstants.baseURL))
        case .userById(let id):
            return URL(
                string: RequestConstants.userById(id: id).path,
                relativeTo: URL(string: RequestConstants.baseURL)
            )
        case .order:
            return URL(
                string: RequestConstants.order.path,
                relativeTo: URL(string: RequestConstants.baseURL))
        case .currencies:
            return URL (
                string: RequestConstants.currencies.path,
                relativeTo: URL(string:
                                    RequestConstants.baseURL)
            )
        case .payment(let id):
            return URL(
                string: RequestConstants.payment(id: id).path,
                relativeTo: URL(string: RequestConstants.baseURL))
        }
    }
}
