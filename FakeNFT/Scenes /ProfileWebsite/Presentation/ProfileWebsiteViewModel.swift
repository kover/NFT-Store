//
//  ProfileWebsiteViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 04.02.2024.
//

import Foundation

final class ProfileWebsiteViewModel: ProfileWebsiteViewModelProtocol {
    
    private let profileLink: String
    
    private var urlRequest: ( (URLRequest?) -> Void )?
    
    private var webLoadingProgress: ( (ProgressState) -> Void )?
    
    init(profileLink: String) {
        self.profileLink = profileLink
    }
    
    func onViewDidLoad() {
        guard let requestUrl = URL(string: profileLink) else {
            urlRequest?(nil)
            return
        }
        let request = URLRequest(url: requestUrl)
        urlRequest?(request)
    }
    
    func urlRequestObserve(_ completion: @escaping (URLRequest?) -> Void) {
        self.urlRequest = completion
    }
    
    func webLoadingProgressObserve(_ completion: @escaping (ProgressState) -> Void) {
        self.webLoadingProgress = completion
    }
    
    func updateProgressValue(_ value: Double) {
        let progressState = ProgressState(
            progressValue: Float(value),
            isHiden: fabs(value - 1.0) <= 0.0001
        )
        webLoadingProgress?(progressState)
    }
}
