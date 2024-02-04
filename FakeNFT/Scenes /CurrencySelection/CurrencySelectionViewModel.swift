//
//  CurrencySelectionViewModel.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 28.01.2024.
//

import Foundation

protocol CurrencySelectionViewModelProtocol {
    var currencies: [CurrencyModel] { get }
    var onError: ((Error) -> Void)? { get set }
    var onCurrenciesLoaded: (() -> Void)? { get set }
    var onPaymentSuccess: (() -> Void)? { get set }
    
    func loadCurrencies()
    func makePayment(with currencyId: String)
    func linkTapped(completion: @escaping (URL) -> Void)
}

final class CurrencySelectionViewModel: CurrencySelectionViewModelProtocol {
    
    private let serviceAssembly: ServicesAssembly
    var currencies: [CurrencyModel] = []
    var onError: ((Error) -> Void)?
    var onCurrenciesLoaded: (() -> Void)?
    var onPaymentSuccess:(() -> Void)?
    
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadCurrencies()
    }
    
    func loadCurrencies() {
        UIBlockingProgressHUD.show()
        
        serviceAssembly.cartService.getCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                DispatchQueue.main.async {
                    self?.onCurrenciesLoaded?()
                }
            case .failure(let error):
                self?.onError?(error)
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func makePayment(with currencyId: String) {
        UIBlockingProgressHUD.show()
        
        serviceAssembly.cartService.makePayment(with: currencyId) { [weak self] result in
            switch result {
            case .success(let response):
                if response.success {
                    self?.onPaymentSuccess?()
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Payment failed."])
                    self?.onError?(error)
                }
            case .failure(let error):
                self?.onError?(error)
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    
    func linkTapped(completion: @escaping (URL) -> Void) {
        if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") {
            completion(url)
        }
    }
    
}
