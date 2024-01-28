//
//  ProfileRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol ProfileRepository {
    
    func saveProfileInfo(_ model: ProfileModel)
    
    func loadProfileInfo() -> ProfileModel
    
}
