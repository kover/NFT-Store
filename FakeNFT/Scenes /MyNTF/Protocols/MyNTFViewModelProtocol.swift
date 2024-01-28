//
//  MyNTFViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol MyNTFViewModelProtocol {
    
    func itemCount() -> Int
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel?
    
}
