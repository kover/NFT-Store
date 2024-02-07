//
//  FavoritesNTFCellDelegate.swift
//  FakeNFT
//
//  Created by Avtor_103 on 07.02.2024.
//

import Foundation

protocol FavoritesNTFCellDelegate {
    
    func onFavoriteStatusChanged(id: String)
    
    func onRefresh(for itemIndex: Int)
}
