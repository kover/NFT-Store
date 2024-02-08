//
//  SettingsRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 08.02.2024.
//

import Foundation

protocol SettingsRepository {
    
    func saveSortingRule(_ rule: SortingRule)
    
    func getSortingRule() -> SortingRule

}
