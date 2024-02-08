//
//  ProfileViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol ProfileViewModelProtocol {
    
    func onViewWillAppear()
    
    func onViewDidAppear()
    
    func onChildControllerWillPresent()
    
    func observeProfileInfo(_ completion: @escaping (ProfileModel) -> Void)
    
    func observeLoadingError(_ completion: @escaping (String) -> Void)
    
    func observeLoadingStatus(_ completion: @escaping (Bool) -> Void)
    
    func getProfilePersonalData() -> ProfilePersonalDataModel?
    
    func getProfileNTFs() -> ProfileNTFsModel
    
    func setProfilePersonalData(_ model: ProfilePersonalDataModel)
    
    func setFavoritesNTFsID(_ favoritesNtsIds: [String])
}
