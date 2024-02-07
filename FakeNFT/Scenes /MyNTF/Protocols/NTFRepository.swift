//
//  NTFRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol NTFRepository {
    
    func loadNTFsByID(_ IDs: [String], handler: @escaping (Int) -> Void)
    
    func loadNTFbyID(id: String, itemIndex: Int, callback: @escaping () -> Void)
    
    func loadNTFsFromCache() -> [NTFModel?]
}
