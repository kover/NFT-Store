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
            NTFRepository: injectNTFRepository()
        )
    }
    
    static func injectMyNTFViewModel() -> MyNTFViewModelProtocol {
        MyNTFViewModel(
            NTFRepository: injectNTFRepository()
        )
    }
    
//MARK: - Repositories injections
    static func injectProfileRepository() -> ProfileRepository {
        ProfileRepositoryImpl()
    }
    
    static func injectNTFRepository() -> NTFRepository {
        NTFRepositoryImpl()
    }
}
