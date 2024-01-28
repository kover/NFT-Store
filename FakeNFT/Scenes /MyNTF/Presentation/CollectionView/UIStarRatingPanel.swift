//
//  StarRatingPanel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 21.01.2024.
//

import UIKit

final class UIStarRatingPanel: UIView {
    
    var inactiveColor: UIColor = .lightGray {
        didSet { stars.forEach { $0.tintColor = self.inactiveColor } }
    }
    
    var activeColor: UIColor = .yellow
    
    var symbolConfiguration = UIImage.SymbolConfiguration(
        pointSize: 10,
        weight: .regular,
        scale: .default
    ) {
        didSet { self.configureCell() }
    }
    
    var starSpacing: CGFloat = 1 {
        didSet { configureCell() }
    }
    
    private var stars = [UIImageView]()
    
    init(starsCount: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
   
        setupStars(starsCount: starsCount)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetRating() {
        for star in stars {
            star.tintColor = inactiveColor
        }
    }
    
    func setRating(_ rating: Int) {
        resetRating()
        if rating < 1 || stars.isEmpty { return }
        
        let _rating = rating > stars.count ? stars.count : rating
        
        for index in 0 ... _rating - 1 {
            stars[index].tintColor = activeColor
        }
    }
    
    private func setupStars(starsCount: Int) {
        if !stars.isEmpty { stars.removeAll() }
        let _starsCount = starsCount < 1 ? 1 : starsCount
        
        for _ in 1 ... _starsCount {
            let star = UIImageView(
                image: UIImage(systemName: "star.fill", withConfiguration: symbolConfiguration)
            )
            star.tintColor = inactiveColor
            stars.append(star)
        }
    }
    
    private func configureCell() {
        if stars.isEmpty { return }
        stars.forEach { $0.removeFromSuperview() }
        
        var previousViewAnchor = self.leadingAnchor
        var spacing: CGFloat = 0
        
        for star in stars {
            self.addSubView(
                star,
                leading: AnchorOf(previousViewAnchor, spacing-2),
                centerY: AnchorOf(self.centerYAnchor)
            )
            previousViewAnchor = star.trailingAnchor
            spacing = starSpacing
        }
    }
}
