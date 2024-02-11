//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 26.01.2024.
//

import Foundation

protocol ProfileServiceProtocol {
    func getProfile(completion: @escaping (Result<Profile, Error>) -> Void)
    func setLikes(_ likes: Likes, completion: @escaping (Result<Profile, Error>) -> Void)
}

struct ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        let request = ProfileRequest()
        networkClient.send(request: request, type: Profile.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func setLikes(_ likes: Likes, completion: @escaping (Result<Profile, Error>) -> Void) {
        let request = LikesRequest(model: likes)
        networkClient.send(request: request, type: Profile.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
