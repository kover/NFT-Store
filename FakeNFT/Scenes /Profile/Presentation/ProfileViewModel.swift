//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {
        
    private let profileRepository: ProfileRepository
    
    private let myNTFRepository: NTFRepository
    
    private let favoritesRepository: NTFRepository
    
    private var updateProfileInfo: ( (ProfileModel) -> Void )?
    
    private var dataLoadingStatus: ( (Bool) -> Void )?
    
    private var loadingProfileError: ( (String) -> Void )?
    
    private var isProfileLoadingAvailable = true
    
    init(
        profileRepository: ProfileRepository,
        myNTFRepository: NTFRepository,
        favoritesRepository: NTFRepository
    ) {
        self.profileRepository = profileRepository
        self.myNTFRepository = myNTFRepository
        self.favoritesRepository = favoritesRepository
    }
    
    func onViewWillAppear() {
        if isProfileLoadingAvailable {
            loadProfileFromServer()
            return
        }
    }
    
    func onViewDidAppear() {
        isProfileLoadingAvailable = true
    }
    
    func onChildControllerWillPresent() {
        isProfileLoadingAvailable = false
    }
    
    func getMyNTFRepository() -> NTFRepository {
        myNTFRepository
    }
    
    func getFavoritesNTFRepository() -> NTFRepository {
        favoritesRepository
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
    
    func getProfileNTFs() -> ProfileNTFsModel {
        guard let profileModel = profileRepository.getProfileFromCache() else {
            return ProfileNTFsModel(myNtfIds: [], favoritesNtsIds: [])
        }
        return ProfileNTFsModel(
            myNtfIds: MockedData.profileModel.myNtfIds, //mocked to check ui for reviewer request //profileModel.myNtfIds,
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
    
    func setFavoritesNTFsID(_ favoritesNtsIds: [String]) {
        guard let cacheProfileModel = profileRepository.getProfileFromCache() else { return }
        
        let updProfileModel = ProfileModel(
            avatarUrl: cacheProfileModel.avatarUrl,
            name: cacheProfileModel.name,
            description: cacheProfileModel.description,
            link: cacheProfileModel.link,
            myNtfIds: cacheProfileModel.myNtfIds,
            favoritesNtsIds: favoritesNtsIds
        )
        saveProfile(updProfileModel)
    }
    
    private func saveProfile(_ updModel: ProfileModel) {
        if updModel == profileRepository.getProfileFromCache() {
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

