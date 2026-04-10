//
//  ItemCell.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import UIKit

final class ItemCell: UITableViewCell {

    static let reuseIdentifier = "ItemCell"

    private let container = UIView()
    private let icon = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        container.backgroundColor = UIColor.systemGreen.withAlphaComponent(StyleGuide.List.backgroundOpacity)
        container.layer.cornerRadius = StyleGuide.List.itemCornerRadius
        container.clipsToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.08
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4

        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.layer.cornerRadius = StyleGuide.List.imageCornerRadius

        titleLabel.font = .boldSystemFont(ofSize: 16)
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.numberOfLines = 2

        contentView.addSubview(container)
        container.addSubview(icon)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)

        container.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // container
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: StyleGuide.List.itemSpacing / 2),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -StyleGuide.List.itemSpacing / 2),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: StyleGuide.Carousel.horizontalPadding),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -StyleGuide.Carousel.horizontalPadding),

            // icon
            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: StyleGuide.List.itemPadding),
            icon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: StyleGuide.List.imageSize),
            icon.heightAnchor.constraint(equalToConstant: StyleGuide.List.imageSize),

            // title
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: StyleGuide.List.itemPadding),
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: StyleGuide.List.itemSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -StyleGuide.List.itemPadding),

            // subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -StyleGuide.List.itemPadding)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with item: ListItem) {
        icon.image = UIImage(named: item.imageName) ?? UIImage(named: "img")
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
