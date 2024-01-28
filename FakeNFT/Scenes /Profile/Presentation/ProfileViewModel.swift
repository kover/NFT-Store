//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {
    
    private let profileRepository: ProfileRepository
    
    private let NTFRepository: NTFRepository
    
    private var isProfileLoadAvailable = true
    
    private var updateProfileInfo: ( (ProfileModel) -> Void )?
    
    private var updateMyNTFCount: ( (Int) -> Void )?
    
    private var updateFavoritesNTFCount: ( (Int) -> Void )?
    
    init(
        profileRepository: ProfileRepository,
        NTFRepository: NTFRepository
    ) {
        self.profileRepository = profileRepository
        self.NTFRepository = NTFRepository
    }
    
    func onViewLoaded() {
       loadProfile()
    }
    
    func profileEditRequire() {
        isProfileLoadAvailable = false
    }
    
    func observeProfileInfo(_ completion: @escaping (ProfileModel) -> Void) {
        self.updateProfileInfo = completion
    }
    
    func observeMyNTFCount(_ completion: @escaping (Int) -> Void) {
        self.updateMyNTFCount = completion
    }
    
    func observeFavoritesNTFCount(_ completion: @escaping (Int) -> Void) {
        self.updateFavoritesNTFCount = completion
    }
    
    func getProfileInfo() -> ProfileModel {
        profileRepository.loadProfileInfo()
    }
    
    func setProfileInfo(_ model: ProfileModel) {
        profileRepository.saveProfileInfo(model)
        updateProfileInfo?(model)
        isProfileLoadAvailable = true
    }
    
    private func loadProfile() {
        updateMyNTFCount?(
            NTFRepository.loadMyNTF().count
        )
        updateFavoritesNTFCount?(
            NTFRepository.loadFavoritesNTF().count
        )
        
        if !isProfileLoadAvailable { return }
    
        updateProfileInfo?(
            profileRepository.loadProfileInfo()
        )
    }
}
