//
//  ProfileWebsiteViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 04.02.2024.
//

import Foundation

protocol ProfileWebsiteViewModelProtocol {
    
    func onViewDidLoad()
    
    func urlRequestObserve(_ completion: @escaping (URLRequest?) -> Void)
    
    func webLoadingProgressObserve(_ completion: @escaping (ProgressState) -> Void)
    
    func updateProgressValue(_ value: Double)
}
