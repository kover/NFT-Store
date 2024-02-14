//
//  SettingsRepositoryImplUserDef.swift
//  FakeNFT
//
//  Created by Avtor_103 on 08.02.2024.
//

import Foundation

final class SettingsRepositoryImplUserDef: SettingsRepository {
    
    private let repository = UserDefaults.standard
    
    private let defaultSortingValue: SortingRule = .byTitle
    
    private let sortingRuleKey = "sortingRule"
    
    func saveSortingRule(_ rule: SortingRule) {
        do {
            try repository.setJSON(codable: rule, forKey: sortingRuleKey)
        } catch {
            return
        }
    }
    
    func getSortingRule() -> SortingRule {
        do {
            let sortingRule = try repository.getJSON(type: SortingRule.self, forKey: sortingRuleKey) ?? defaultSortingValue
            return sortingRule
        } catch {
            return defaultSortingValue
        }
        

    }
    
    
}
