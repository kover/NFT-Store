//
//  ProfileRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class ProfileRepositoryImpl: ProfileRepository {
    
    private let networkClient: NetworkClient
    
    private var cache: ProfileModel?
    
    init(
        networkClient: NetworkClient
    ) {
        self.networkClient = networkClient
    }
    
    func saveProfile(model: ProfileModel, handler: @escaping (Error?) -> Void) {
        let requestBody = map(model)

        let profileRequest = ProfileNetworkRequest(requestBody: requestBody, httpMethod: .put)

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
            request: ProfileNetworkRequest(httpMethod: .get),
            type: ProfileResponseBody.self
        ) { (result: Result<ProfileResponseBody, Error>) in
            switch result {
            case .success(let profileResponseBody):
                let profileModel = self.map(profileResponseBody)
                self.cache = profileModel
                handler(.success(profileModel))
            case .failure(let error):
                handler(.failure(error))
            }

        }
    }
        
    func getProfileFromCache() -> ProfileModel? {
        return cache
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

