final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var catalogService: CatalogServiceProtocol {
        CatalogService(networkClient: networkClient)
    }

    var collectionService: CollectionServiceProtocol {
        CollectionService(networkClient: networkClient)
    }

    var profileService: ProfileServiceProtocol {
        ProfileService(networkClient: networkClient)
    }

    var orderService: OrderServiceProtocol {
        OrderService(networkClient: networkClient)
    }

    var currencyService: CurrencyServiceProtocol {
        CurrencyService(networkClient: networkClient)
    }
}
