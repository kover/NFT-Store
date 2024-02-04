//
//  DI.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class DI {

//MARK: - ViewModels injections
    static func injectProfileViewModel() -> ProfileViewModelProtocol {
        ProfileViewModel(
            profileRepository: injectProfileRepository()
        )
    }
    
    static func injectMyNTFViewModel() -> MyNTFViewModelProtocol {
        MyNTFViewModel(
            NTFRepository: injectNTFRepository()
        )
    }
    
    static func injectFavoritesNTFViewModel() -> FavoritesNTFViewModelProtocol {
        FavoritesNTFViewModel(
            NTFRepository: injectNTFRepository()
        )
    }
    
    static func injectProfileWebsiteViewModel(profileLink: String) -> ProfileWebsiteViewModelProtocol {
        ProfileWebsiteViewModel(profileLink: profileLink)
    }
    
//MARK: - Repositories injections
    static func injectProfileRepository() -> ProfileRepository {
        ProfileRepositoryImpl(
            networkClient: injectNetworkClient()
        )
    }
    
    static func injectNTFRepository() -> NTFRepository {
        NTFRepositoryImpl()
    }
    
//MARK: - Services
    static func injectNetworkClient() -> NetworkClient {
        DefaultNetworkClient()
    }
}
