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
            profileRepository: injectProfileRepository(),
            myNTFRepository: injectNTFRepository(),
            favoritesRepository: injectNTFRepository()
        )
    }
    
    static func injectMyNTFViewModel(
        profileNTFsModel: ProfileNTFsModel,
        ntfRepository: NTFRepository
    ) -> MyNTFViewModelProtocol {
        MyNTFViewModel(
            ntfRepository: ntfRepository,
            settingsRepository: injectSettingsRepository(),
            profileNTFsModel: profileNTFsModel
        )
    }
    
    static func injectFavoritesNTFViewModel(
        favoritesNTFsID: [String],
        ntfRepository: NTFRepository
    ) -> FavoritesNTFViewModelProtocol {
        FavoritesNTFViewModel(
            ntfRepository: ntfRepository,
            favoritesNTFsID: favoritesNTFsID
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
        NTFRepositoryImpl(
            networkClient: injectNetworkClient()
        )
    }
    
    static func injectSettingsRepository() -> SettingsRepository {
        SettingsRepositoryImplUserDef()
    }
    
//MARK: - Services
    static func injectNetworkClient() -> NetworkClient {
        DefaultNetworkClient()
    }
}
