//
//  localized.swift
//  FakeNFT
//
//  Created by Avtor_103 on 17.01.2024.
//

import Foundation

func localized(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
    NSLocalizedString(
        key,
        tableName: tableName,
        bundle: bundle,
        value: value,
        comment: comment
    )
}
