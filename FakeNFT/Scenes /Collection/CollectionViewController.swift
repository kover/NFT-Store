//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 22.01.2024.
//

import UIKit
import Kingfisher

final class CollectionViewController: UIViewController {

    private let viewModel: CollectionViewModel

    private lazy var collectionCoverImageView: UIImageView = {
        let coverImageView = UIImageView()

        return coverImageView
    }()

    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }

}
