//
//  AgreementWebViewController.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 29.01.2024.
//

import UIKit
import WebKit

final class AgreementWebViewController: UIViewController {
    private var webView: WKWebView?
    private var url: URL?
    
    func setURL(_ url: URL) {
        self.url = url
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView?.load(URLRequest(url: url))
        }
    }
}

