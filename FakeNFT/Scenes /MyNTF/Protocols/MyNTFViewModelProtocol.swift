//
//  MyNTFViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol MyNTFViewModelProtocol {
    
    func onViewWillAppear()
    
    func itemCount() -> Int
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel?
    
    func refreshObject(for indexPath: IndexPath)
    
    func changeFavoriteNTFStatus(for indexPath: IndexPath)
    
    func sortNTFs(_ rule: SortingRule)
    
    func getUpdatedFavoritesNTFsIds() -> [String]
    
    func observeUpdateNTFModel(_ completion: @escaping (IndexPath) -> Void)
    
    func observeUpdateNTFCollection(_ completion: @escaping () -> Void)
    
    func observeUpdatedPlaceholderState(_ completion: @escaping (Bool) -> Void)
    
}
