//
//  StatsViewController.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import UIKit

final class StatsViewController: UIViewController {

    private let items: [ListItem]
    private let pageIndex: Int

    private lazy var stats: [(Character, Int)] = {
        calculateStats(from: items, limit: 3)
    }()

    init(items: [ListItem], pageIndex: Int) {
        self.items = items
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
    }
}

private extension StatsViewController {

    func setupUI() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = StyleGuide.Stats.cornerRadius
        blurView.layer.masksToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)

        let container = UIView()
        container.backgroundColor = .clear
        container.layer.cornerRadius = StyleGuide.Stats.cornerRadius
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)

        let titleLabel = makeLabel(
            text: "Page \(pageIndex + 1)",
            font: .preferredFont(forTextStyle: .headline)
        )
        titleLabel.font = .systemFont(ofSize: titleLabel.font.pointSize, weight: .bold)

        let countLabel = makeLabel(
            text: "Items count: \(items.count)",
            font: .preferredFont(forTextStyle: .subheadline)
        )

        let statLabels = stats.map { char, count in
            makeLabel(text: "\(char) = \(count)", font: .preferredFont(forTextStyle: .subheadline))
        }

        let stack = UIStackView(arrangedSubviews: [titleLabel, countLabel] + statLabels)
        stack.axis = .vertical
        stack.spacing = StyleGuide.Stats.verticalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: StyleGuide.Paddings.large),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: StyleGuide.Paddings.large),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -StyleGuide.Paddings.large),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -StyleGuide.Paddings.large)
        ])
    }
}

private extension StatsViewController {

    func makeLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 1
        return label
    }
    
    private func topCharacters(from items: [ListItem], limit: Int) -> [(Character, Int)] {
        
        let text = items
            .map { $0.title + " " + $0.subtitle }
            .joined()
            .lowercased()
            .filter { $0.isLetter }
        
        var counts: [Character: Int] = [:]
        
        for char in text {
            counts[char, default: 0] += 1
        }
        
        return counts
            .sorted {
                if $0.value == $1.value {
                    return $0.key < $1.key
                }
                return $0.value > $1.value
            }
            .prefix(limit)
            .map { ($0.key, $0.value) }
    }
}

private extension StatsViewController {

    func calculateStats(from items: [ListItem], limit: Int) -> [(Character, Int)] {
        
        let text = items
            .flatMap { [$0.title, $0.subtitle] }
            .joined(separator: " ")
            .lowercased()
            .filter { $0.isLetter }

        var counts: [Character: Int] = [:]

        for char in text {
            counts[char, default: 0] += 1
        }

        return counts
            .sorted {
                if $0.value == $1.value {
                    return $0.key < $1.key
                }
                return $0.value > $1.value
            }
            .prefix(limit)
            .map { ($0.key, $0.value) }
    }
}
