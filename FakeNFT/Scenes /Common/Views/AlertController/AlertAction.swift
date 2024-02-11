//
//  AlertAction.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

struct AlertAction {
    let title: String
    let action: () -> Void
    
    init(title: String, _ action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
