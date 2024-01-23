//
//  StarRatingPanel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 21.01.2024.
//

import UIKit

class StarRatingPanel {
    
    let view = UIView()
    
    var inactiveColor: UIColor = .lightGray
    
    var activeColor: UIColor = .yellow
    
    var symbolConfiguration =
        UIImage.SymbolConfiguration(pointSize: 10, weight: .regular, scale: .default)
    
    var starSpacing: CGFloat = 1
    
    private let starsCount: Int
    
    private var stars = [UIImageView]()
    
    init(starsCount: Int) {
        self.starsCount = starsCount
    }
    
    func setup() {
        setupStars()
        configureCell()
    }
    
    func resetRating() {
        for star in stars {
            star.tintColor = inactiveColor
        }
    }
    
    func setRating(_ rating: Int) {
        resetRating()
        if rating < 1 || stars.isEmpty { return }
        
        let _rating = rating > starsCount ? starsCount : rating
        
        for index in 0 ... _rating - 1 {
            stars[index].tintColor = activeColor
        }
    }
    
    private func setupStars() {
        for _ in 0 ... starsCount - 1 {
            let star = UIImageView(
                image: UIImage(systemName: "star.fill", withConfiguration: symbolConfiguration)
            )
            star.tintColor = inactiveColor
            stars.append(star)
        }
    }
    
    private func configureCell() {
        if stars.isEmpty { return }
        var previousViewAnchor = view.leadingAnchor
        var spacing: CGFloat = 0
        
        for star in stars {
            view.addSubView(
                star,
                leading: AnchorOf(previousViewAnchor, spacing-2),
                centerY: AnchorOf(view.centerYAnchor)
            )
            previousViewAnchor = star.trailingAnchor
            spacing = starSpacing
        }
    }
}
