//
//  NTFRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class NTFRepositoryImpl: NTFRepository {
   
    private let networkClient: NetworkClient
    
    private var myNTFsCache = [NTFModel]()

    private var favoritesNTFsCache = [NTFModel]()
    
    private let requestQueue = RequestQueue<String>()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadMyNTFsByID(_ ntfModel: ProfileNTFsModel, handler: @escaping ([NTFModel]?) -> Void) {
        requestQueue.add(ntfModel.myNtfIds)
        requestQueue.onFinished {
            if self.myNTFsCache.isEmpty {
                handler(nil)
                return
            }
            handler(self.myNTFsCache)
        }
        
        requestQueue.request { ntfID in
            self.loadNTFbyID(ntfID) { [weak self] (result: Result<NTFResponseBody, Error>) in
                guard let self else { return }
                switch result {
                case .success(let ntfResponseBody):
                    self.myNTFsCache.append(
                        self.map(dto: ntfResponseBody, favoritesNtfIDs: ntfModel.favoritesNtsIds)
                    )
                    requestQueue.next()
                case .failure(_):
                    requestQueue.next()
                }
            }
        }
        requestQueue.next()
    }
    
    func loadFavoritesNTFsByID(_ IDs: [String], handler: @escaping ([NTFModel]?) -> Void) {
        requestQueue.add(IDs)
        requestQueue.onFinished {
            if self.favoritesNTFsCache.isEmpty {
                handler(nil)
                return
            }
            handler(self.favoritesNTFsCache)
        }
        
        requestQueue.request { ntfID in
            self.loadNTFbyID(ntfID) { [weak self] (result: Result<NTFResponseBody, Error>) in
                guard let self else { return }
                switch result {
                case .success(let ntfResponseBody):
                    self.favoritesNTFsCache.append(
                        self.map(dto: ntfResponseBody, favoritesNtfIDs: IDs)
                    )
                    requestQueue.next()
                case .failure(_):
                    requestQueue.next()
                }
            }
        }
        requestQueue.next()
    }
    
    func loadFavoritesNTFsFromCache() -> [NTFModel] {
        favoritesNTFsCache
    }
    
    private func loadNTFbyID(_ id: String, handler: @escaping (Result<NTFResponseBody, Error>)-> Void) {
        let ntsRequest = NFTRequest(id: id)
        
        networkClient.send(
            request: ntsRequest,
            type: NTFResponseBody.self) { (result: Result<NTFResponseBody, Error>) in
                switch result {
                case .success(let ntfResponseBody):
                    handler(.success(ntfResponseBody))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        
    }
    
    private func map(dto: NTFResponseBody, favoritesNtfIDs: [String]) -> NTFModel {
        let artworkStringUrl = dto.images.first ?? ""
        
        return NTFModel(
            id: dto.id,
            title: dto.name,
            artworkUrl: URL(string: artworkStringUrl),
            author: dto.author,
            price: dto.price,
            currency: "ETH",//mocked
            rating: dto.rating,
            isFavorite: checkNTFisFavorite(id: dto.id, favoritesNtfIDs: favoritesNtfIDs)
        )
    }
    
    private func checkNTFisFavorite(id: String, favoritesNtfIDs: [String]) -> Bool {
        for favoritesNtfID in favoritesNtfIDs where favoritesNtfID == id {
            return true
        }
        return false
    }
}
