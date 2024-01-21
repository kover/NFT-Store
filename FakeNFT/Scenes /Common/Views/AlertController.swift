//
//  AlertController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 21.01.2024.
//

import UIKit

protocol AlertPresenterProtocol {
    func present(alert: UIAlertController, animated: Bool)
}

struct alertAction {
    let title: String
    let action: () -> Void
    
    init(title: String, _ action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

final class AlertController {
    
    static func multiAction(
        alertPresenter: AlertPresenterProtocol,
        title: String?,
        actions: [alertAction]
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        for action in actions {
            alert.addAction(
                UIAlertAction(title: action.title, style: .destructive) { _ in action.action()}
            )
        }
        alert.addAction(UIAlertAction(title: localized("Cancel"), style: .cancel, handler: nil))
        
        alertPresenter.present(alert: alert, animated: true)
    }
    
    static func removeObject(
        alertPresenter: AlertPresenterProtocol,
        title: String,
        _ completion: @escaping () -> Void
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
         
        alert.addAction(UIAlertAction(title: localized("Delete"), style: .destructive) { _ in
            completion()
        })
        alert.addAction(UIAlertAction(title: localized("Cancel"), style: .cancel, handler: nil))
         
        alertPresenter.present(alert: alert, animated: true)
    }
    
    static func showNotification(
        alertPresenter: AlertPresenterProtocol,
        title: String,
        message: String,
        _ completion: ( () -> Void )? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
         
        alert.addAction(UIAlertAction(title: localized("ok"), style: .default) { _ in
            completion?()
        })
         
        alertPresenter.present(alert: alert, animated: true)
    }
}
