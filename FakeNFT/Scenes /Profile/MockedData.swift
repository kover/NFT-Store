//
//  MockedData.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import UIKit

enum MockedData {
    static let NTFList = [
        NTFModel(id: "01", title: "Lilo", artwork: UIImage(named: "NTF1") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 3, isFavorite: false),
        NTFModel(id: "02", title: "Spring", artwork: UIImage(named: "NTF2") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 4, isFavorite: true),
        NTFModel(id: "03", title: "Stich", artwork: UIImage(named: "NTF1") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 2, isFavorite: false),
        NTFModel(id: "04", title: "Venom", artwork: UIImage(named: "NTF2") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 5, isFavorite: true)
    ]
}
