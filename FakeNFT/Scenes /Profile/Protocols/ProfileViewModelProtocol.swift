//
//  ProfileViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol ProfileViewModelProtocol {
    
    func onViewLoaded()
    
    func profileEditRequire()
    
    func observeProfileInfo(_ completion: @escaping (ProfileModel) -> Void)
    
    func observeMyNTFCount(_ completion: @escaping (Int) -> Void)
    
    func observeFavoritesNTFCount(_ completion: @escaping (Int) -> Void)
    
    func getProfileInfo() -> ProfileModel
    
    func setProfileInfo(_ model: ProfileModel)
}
