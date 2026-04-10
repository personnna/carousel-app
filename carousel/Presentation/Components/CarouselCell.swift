//
//  CarouselCell.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import UIKit

final class CarouselCell: UICollectionViewCell {

    static let reuseIdentifier = "CarouselCell"

    private let cardView = UIView()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(cardView)
        cardView.addSubview(imageView)

        cardView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        cardView.layer.cornerRadius = StyleGuide.Carousel.cornerRadius
        cardView.clipsToBounds = false
        cardView.backgroundColor = .clear
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.15
        cardView.layer.shadowOffset = CGSize(width: 0, height: StyleGuide.Carousel.shadowYOffset)
        cardView.layer.shadowRadius = StyleGuide.Carousel.shadowRadius

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = StyleGuide.Carousel.cornerRadius

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: StyleGuide.Carousel.horizontalPadding),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -StyleGuide.Carousel.horizontalPadding),

            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(imageName: String = "img") {
        imageView.image = UIImage(named: imageName)
    }
}
