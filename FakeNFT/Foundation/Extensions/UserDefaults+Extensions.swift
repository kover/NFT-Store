//
//  UserDefaults+Extensions.swift
//  FakeNFT
//
//  Created by Avtor_103 on 08.02.2024.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsErrors: Error {
            case setError
            case getError
    }

    func setJSON <T: Codable> (codable: T, forKey key: String) throws {
        do {
            let data = try JSONEncoder().encode(codable)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            throw UserDefaultsErrors.setError
        }
    }
        
    func getJSON <T: Codable> (type: T.Type, forKey key: String) throws -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let encodingData = try JSONDecoder().decode(T.self, from: data)
            return encodingData
        } catch {
            throw UserDefaultsErrors.getError
        }
    }
}
