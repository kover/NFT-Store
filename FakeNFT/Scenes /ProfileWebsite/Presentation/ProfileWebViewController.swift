//
//  ProfileWebViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 04.02.2024.
//

import UIKit
import WebKit

final class ProfileWebViewController: UIViewController {
    
    private let viewModel: ProfileWebsiteViewModelProtocol
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    private let backButton: UIButton = {
        let backButtonImage = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .default)
        )
        let button = UIButton.systemButton(
            with: backButtonImage ?? UIImage(),
            target: nil,
            action: #selector(onBackButtonClick)
        )
        button.tintColor = .ypBlack
        button.backgroundColor = .clear
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .ypWhite
        return webView
    }()
    
    private let progressView: UIProgressView = {
        let uiProgressView = UIProgressView()
        uiProgressView.progressTintColor = .ypBlue
        return uiProgressView
    }()
    
    init(viewModel: ProfileWebsiteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        
        viewModel.urlRequestObserve{ [weak self] request in
            guard let self else { return }
            guard let request else {
                self.onUpdateWebsiteError()
                return
            }
            self.updateWebsite(request)
        }
        viewModel.webLoadingProgressObserve{ [weak self] state in
            guard let self else { return }
            self.setProgressValue(state.progressValue)
            self.setProgressHidden(state.isHiden)
        }
        viewModel.onViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 viewModel.updateProgressValue(webView.estimatedProgress)
             }
        )
    }
    
    private func updateWebsite(_ request: URLRequest) {
        webView.load(request)
    }
    
    private func setProgressValue(_ value: Float) {
        progressView.progress = value
    }
    
    private func setProgressHidden(_ isHidden: Bool) {
        progressView.isHidden = isHidden
    }
    
    private func onUpdateWebsiteError() {
        //TODO show allert if url error
    }
    
    @objc
    private func onBackButtonClick() {
        dismiss(animated: true)
    }
}

//MARK: - Configure layout
extension ProfileWebViewController {
    private func configureLayout() {
        view.backgroundColor = .ypWhite
        
        view.addSubView(
            backButton, width: 24, heigth: 24,
            top: AnchorOf(view.safeAreaLayoutGuide.topAnchor, 8),
            leading: AnchorOf(view.leadingAnchor, 8)
        )
        
        view.addSubView(
            webView,
            top: AnchorOf(backButton.bottomAnchor, 8),
            bottom: AnchorOf(view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor),
            trailing: AnchorOf(view.trailingAnchor)
        )
        
        view.addSubView(
            progressView,
            top: AnchorOf(backButton.bottomAnchor, 8),
            leading: AnchorOf(view.leadingAnchor),
            trailing: AnchorOf(view.trailingAnchor)
        )
    }
}
