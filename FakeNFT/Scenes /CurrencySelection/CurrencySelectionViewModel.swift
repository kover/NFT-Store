//
//  CurrencySelectionViewModel.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 28.01.2024.
//

import Foundation

final class CurrencySelectionViewModel {
    
    private let serviceAssembly: ServicesAssembly
    
 // temporary data
    let currencies: [CurrencyModel] = [
        CurrencyModel(title: "Bitcoin", name: "BTC", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png", id: "1"),
        CurrencyModel(title: "Dogecoin", name: "DOGE", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png", id: "2"),
        CurrencyModel(title: "Tether", name: "USDT", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png", id: "3"),
        CurrencyModel(title: "Apecoin", name: "APE", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/ApeCoin_(APE).png", id: "4"),
        CurrencyModel(title: "Solana", name: "SOL", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png", id: "5"),
        CurrencyModel(title: "Ethereum", name: "ETH", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png", id: "6"),
        CurrencyModel(title: "Cardano", name: "ADA", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png", id: "7"),
        CurrencyModel(title: "Shiba Inu", name: "SHIB", imageURL: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png", id: "8")
    ]
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func linkTapped(completion: @escaping (URL) -> Void) {
            if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") {
                completion(url)
            }
        }
}
