//
//  DetailCollectionViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import UIKit
import Kingfisher

class DetailsImageCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(imageUrl: String?) {
        guard let imageUrl = imageUrl else {
            return
        }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: imageUrl))
    }
}
private extension DetailsImageCollectionViewCell {
    func setupSubviews() {
        [imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func addCornerRadius() {
        let maskPath = UIBezierPath(
            roundedRect: imageView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 40, height: 40)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = imageView.bounds
        maskLayer.path = maskPath.cgPath
        imageView.layer.mask = maskLayer
    }
}
