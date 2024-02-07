//
//  CurrencyConstants.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 31.01.2024.
//

import Foundation

enum CurrencyConstants: String {
    case dgld = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"
    case uslv = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png"
    case eplt = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png"
    case dbrs = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png"
    case mpl = "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png"

    static func urlFromString(string: String) -> CurrencyConstants {
        switch string {
        case "DGLD":
            return .dgld
        case "USLV":
            return .uslv
        case "EPLT":
            return .eplt
        case "DBRS":
            return .dbrs
        case "MPL":
            return .mpl
        default:
            return .dgld
        }
    }
}
