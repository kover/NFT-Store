//
//  DetailsContentViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 30.01.2024.
//

import Foundation

final class DetailsContentViewModel {
    private let serviceAssembly: ServicesAssembly
    private var alertPresenter: AlertPresenterProtocol?

    @Observable
    private(set) var currencies: [Currency] = []

    init(
        serviceAssembly: ServicesAssembly,
        alertPresenter: AlertPresenterProtocol? = nil
    ) {
        self.serviceAssembly = serviceAssembly
        self.alertPresenter = alertPresenter
        loadCurrencies()
    }

    func loadCurrencies() {
        UIBlockingProgressHUD.show()
        serviceAssembly.currencyService.getCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
            case .failure:
                self?.showNetworkError {
                    self?.loadCurrencies()
                }
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
}
// MARK: - Private routines
private extension DetailsContentViewModel {
    func showNetworkError(completion: @escaping () -> Void) {
        guard let alertPresenter = alertPresenter else {
            return
        }
        let model = Alert(
            title: NSLocalizedString("Error.title", comment: "Title for the error alert"),
            message: NSLocalizedString("Error.network", comment: "Message for the network error"),
            actionTitle: NSLocalizedString("Error.repeat", comment: "Title for the repeat button"),
            completion: completion
        )
        alertPresenter.showAlert(using: model)
    }
}
