//
//  ProfileRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol ProfileRepository {
    
    func saveProfile(model: ProfileModel, handler: @escaping (Error?) -> Void)
    
    func loadProfile(handler: @escaping (Result<ProfileModel, Error>) -> Void)
    
    func getProfileFromCache() -> ProfileModel?    
}
