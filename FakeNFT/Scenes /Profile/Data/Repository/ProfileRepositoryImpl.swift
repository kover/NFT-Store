//
//  ProfileRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class ProfileRepositoryImpl: ProfileRepository {
    
    //mocked storage
    private var profileInfo: ProfileModel = MockedData.profileInfo
    
    func saveProfileInfo(_ model: ProfileModel) {
        self.profileInfo = model
    }
    
    func loadProfileInfo() -> ProfileModel {
        profileInfo
    }
}
