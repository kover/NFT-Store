//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 28.01.2024.
//

import UIKit

protocol AlertPresenterProtocol {
    var delegate: UIViewController? { get set }
    func showAlert(using model: Alert)
}

final class AlertPresenter: AlertPresenterProtocol {
    var delegate: UIViewController?

    func showAlert(using model: Alert) {
        guard let delegate = delegate else {
            return
        }
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = "AlertWindow"
        let action = UIAlertAction(title: model.actionTitle, style: .default) { _ in
            model.completion()
        }
        alert.addAction(action)
        delegate.present(alert, animated: true)
    }
}
