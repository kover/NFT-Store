//
//  AuthorPageViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 23.01.2024.
//

import UIKit
import WebKit

class AuthorPageViewController: UIViewController, WKNavigationDelegate {

    var url: String?

    private lazy var webView: WKWebView = {
        let wkWebView = WKWebView()
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.backgroundColor = .ypWhite
        wkWebView.navigationDelegate = self
        return wkWebView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .ypBlack
        view.backgroundColor = .ypWhite

        setupSubviews()
        setupLayout()

        guard let urlString = url, let url = URL(string: urlString) else {
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
// MARK: - Private routines
private extension AuthorPageViewController {
    func setupSubviews() {
        view.addSubview(webView)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
