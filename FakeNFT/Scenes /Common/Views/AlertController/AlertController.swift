//
//  AlertController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 21.01.2024.
//

import UIKit

final class AlertController {
    
    static func multiAction(
        alertPresenter: AlertPresentationProtocol,
        title: String?,
        actions: [AlertAction]
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        for action in actions {
            let alertAction = UIAlertAction(
                title: action.title,
                style: .default
            ) { _ in action.action()}
            
            alert.addAction(alertAction)
        }
        alert.addAction(
            UIAlertAction(
                title: localized("Cancel"),
                style: .cancel,
                handler: nil
            )
        )
        
        alertPresenter.present(alert: alert, animated: true)
    }
    
    static func removeObject(
        alertPresenter: AlertPresentationProtocol,
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
        alertPresenter: AlertPresentationProtocol,
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
    
    static func showInputDialog(
        alertPresenter: AlertPresentationProtocol,
        title: String,
        action: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: localized("ok"), style: .default) { _ in
            guard let textField = alert.textFields?.first as UITextField? else { return }
            guard let stringUrl = textField.text else { return }
            action(stringUrl)
        })
        
        alert.addAction(UIAlertAction(title: localized("Cancel"), style: .cancel, handler: nil))
        alert.addTextField()
        alertPresenter.present(alert: alert, animated: true)
        
    }
}
