//
//  FavoritesNTFCellDelegate.swift
//  FakeNFT
//
//  Created by Avtor_103 on 07.02.2024.
//

import Foundation

protocol NTFCellDelegate {
    
    func onFavoriteStatusChanged(with indexPath: IndexPath)
    
    func onRefresh(with indexPath: IndexPath)
}
