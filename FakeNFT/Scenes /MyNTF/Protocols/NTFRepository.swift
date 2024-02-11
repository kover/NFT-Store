//
//  NTFRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol NTFRepository {
    
    func loadNTFsByID(_ IDs: [String], handler: @escaping (String, NTFModel?) -> Void)
        
    func loadNTFByID(_ id: String, handler: @escaping (NTFModel?) -> Void)
}
