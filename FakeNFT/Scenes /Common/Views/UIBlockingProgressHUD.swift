//
//  UIBlockingProgressHUD.swift
//  FakeNFT
//
//  Created by Avtor_103 on 31.01.2024.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    
    static func dismiss() {
        ProgressHUD.dismiss()
        window?.isUserInteractionEnabled = true
    }
    
    static func execute(_ isShowed: Bool) {
        if isShowed { self.show() }
        if !isShowed { self.dismiss() }
    }
}
