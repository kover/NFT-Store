//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {
        
    private let profileRepository: ProfileRepository
    
    private var updateProfileInfo: ( (ProfileModel) -> Void )?
    
    private var dataLoadingStatus: ( (Bool) -> Void )?
    
    private var loadingProfileError: ( (String) -> Void )?
    
    private var isProfileLoadingAvailable = true
    
    init(
        profileRepository: ProfileRepository
    ) {
        self.profileRepository = profileRepository
    }
    
    func onViewWillAppear() {
        if isProfileLoadingAvailable {
            loadProfileFromServer()
            return
        }
        isProfileLoadingAvailable = true
    }
    
    func onProfileWebsiteWillPresent() {
        isProfileLoadingAvailable = false
    }
    
    func observeProfileInfo(_ completion: @escaping (ProfileModel) -> Void) {
        self.updateProfileInfo = completion
    }
    
    func observeLoadingError(_ completion: @escaping (String) -> Void) {
        self.loadingProfileError = completion
    }
    
    func observeLoadingStatus(_ completion: @escaping (Bool) -> Void) {
        self.dataLoadingStatus = completion
    }
    
    func getProfilePersonalData() -> ProfilePersonalDataModel? {
        guard let profileModel = profileRepository.getProfileFromCache() else { return nil }
        return ProfilePersonalDataModel(
            avatarUrl: profileModel.avatarUrl,
            name: profileModel.name,
            description: profileModel.description,
            link: profileModel.link
        )
    }
    
    func getProfileNTFs() -> ProfileNTFsModel? {
        guard let profileModel = profileRepository.getProfileFromCache() else { return nil }
        return ProfileNTFsModel(
            myNtfIds: profileModel.myNtfIds,
            favoritesNtsIds: profileModel.favoritesNtsIds
        )
    }
    
    func setProfilePersonalData(_ model: ProfilePersonalDataModel) {
        guard let cacheProfileModel = profileRepository.getProfileFromCache() else { return }
        
        let updProfileModel = ProfileModel(
            avatarUrl: model.avatarUrl,
            name: model.name,
            description: model.description,
            link: model.link,
            myNtfIds: cacheProfileModel.myNtfIds,
            favoritesNtsIds: cacheProfileModel.favoritesNtsIds
        )
        saveProfile(updProfileModel)
    }
    
    func setProfileNTFs(_ model: ProfileNTFsModel) {
        guard let cacheProfileModel = profileRepository.getProfileFromCache() else { return }
        
        let updProfileModel = ProfileModel(
            avatarUrl: cacheProfileModel.avatarUrl,
            name: cacheProfileModel.name,
            description: cacheProfileModel.description,
            link: cacheProfileModel.link,
            myNtfIds: model.myNtfIds,
            favoritesNtsIds: model.favoritesNtsIds
        )
        saveProfile(updProfileModel)
    }
    
    private func saveProfile(_ updModel: ProfileModel) {
        isProfileLoadingAvailable = false
        if updModel == profileRepository.getProfileFromCache() {
            isProfileLoadingAvailable = true
            return
        }
        
        updateProfileInfo?(updModel)
        dataLoadingStatus?(true)
        
        profileRepository.saveProfile(model: updModel) { [weak self] error in
            guard let self else { return }
            self.dataLoadingStatus?(false)
            
            if let error {
                self.loadingProfileError?(error.localizedDescription)
                self.loadProfileFromCache()
            }
            self.isProfileLoadingAvailable = true
        }
    }
    
    private func loadProfileFromServer() {
        dataLoadingStatus?(true)
        profileRepository.loadProfile{ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profileModel):
                self.dataLoadingStatus?(false)
                self.updateProfileInfo?(profileModel)
            case .failure(let error):
                self.dataLoadingStatus?(false)
                self.loadingProfileError?(error.localizedDescription)
            }
        }
    }
    
    private func loadProfileFromCache() {
        if let model = profileRepository.getProfileFromCache() {
            updateProfileInfo?(model)
        }
    }
}

