//
//  ProfileRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class ProfileRepositoryImpl: ProfileRepository {
    
    private let networkClient: NetworkClient
    
    private var responseCache: ProfileResponseBody?
    
    init(
        networkClient: NetworkClient
    ) {
        self.networkClient = networkClient
    }
    
    func saveProfile(model: ProfileModel, handler: @escaping (Error?) -> Void) {
        let requestBody = map(model)
        
        let profileRequest = ProfileRequest(requestBody: requestBody, httpMethod: .put)
        
        self.networkClient.send(
            request: profileRequest
        ) { result in
            switch result {
            case .success( _ ):
                handler(nil)
            case .failure(let error):
                handler(error)
            }
        }
    }
    
    func loadProfile(handler: @escaping (Result<ProfileModel, Error>) -> Void) {
        networkClient.send(
            request: ProfileRequest(httpMethod: .get),
            type: ProfileResponseBody.self
        ) { (result: Result<ProfileResponseBody, Error>) in
            switch result {
            case .success(let profileResponseBody):
                self.responseCache = profileResponseBody
                handler(
                    .success(
                        self.map(profileResponseBody)
                    )
                )
            case .failure(let error):
                handler(.failure(error))
            }
                
        }
    }
        
    func getProfileFromCache() -> ProfileModel? {
        guard let responseCache = self.responseCache else { return nil }
        return map(responseCache)
    }
    
    private func map(_ responseModel: ProfileResponseBody) -> ProfileModel {
        ProfileModel(
            avatarUrl: URL(string: responseModel.avatar),
            name: responseModel.name,
            description: responseModel.description,
            link: responseModel.website,
            myNtfIds: responseModel.nfts,
            favoritesNtsIds: responseModel.likes
        )
    }
    
    private func map(_ model: ProfileModel) -> ProfileRequestBody {
        ProfileRequestBody(
            name: model.name,
            avatar: model.avatarUrl?.absoluteString ?? "",
            description: model.description,
            website: model.link,
            likes: model.favoritesNtsIds
        )
    }
}

