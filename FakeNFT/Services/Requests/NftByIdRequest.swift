import Foundation

struct NftByIdRequest: NetworkRequest {

    let id: String

    var endpoint: URL? {
        RequestConstants.nftById(id: self.id).url
    }
    
    var httpMethod: HttpMethod {
        .get
    }
}
