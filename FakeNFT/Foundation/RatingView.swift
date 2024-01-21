//
//  RatingView.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 21.01.2024.
//

import UIKit

class RatingView: UIStackView {
    var rating: Int = 0 {
        didSet {
            updateRating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRatingView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupRatingView()
    }
    
    private func setupRatingView() {
        spacing = 2
        
        for _ in 1...5 {
            let starImageView = UIImageView(image: UIImage(named: "Star_empty"))
            starImageView.contentMode = .scaleAspectFit
            addArrangedSubview(starImageView)
        }
    }
    
    private func updateRating() {
        for (index, subview) in arrangedSubviews.enumerated() {
            if let starImageView = subview as? UIImageView {
                if index < rating {
                    starImageView.image = UIImage(named: "Star_filled")
                } else {
                    starImageView.image = UIImage(named: "Star_empty")
                }
            }
        }
    }
}
