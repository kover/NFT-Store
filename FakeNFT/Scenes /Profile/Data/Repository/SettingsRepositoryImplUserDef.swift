//
//  SettingsRepositoryImplUserDef.swift
//  FakeNFT
//
//  Created by Avtor_103 on 08.02.2024.
//

import Foundation

final class SettingsRepositoryImplUserDef: SettingsRepository {
    
    private let repository = UserDefaults.standard
    
    private let sortingRuleKey = "sortingRule"
    
    func saveSortingRule(_ rule: SortingRule) {
        repository.setJSON(codable: rule, forKey: sortingRuleKey)
    }
    
    func getSortingRule() -> SortingRule {
        let sortingRule = repository.getJSON(type: SortingRule.self, forKey: sortingRuleKey) ?? .byTitle
        return sortingRule
    }
    
    
}
