//
//  StyleGuide.swift
//  carousel
//
//  Created by ellkaden on 17/02/26.
//

import UIKit

enum StyleGuide {

    enum Carousel {
        static let height: CGFloat = 180
        static let horizontalPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let shadowRadius: CGFloat = 6
        static let shadowYOffset: CGFloat = 4
    }

    enum List {
        static let itemSpacing: CGFloat = 10
        static let itemPadding: CGFloat = 16
        static let itemCornerRadius: CGFloat = 12
        static let imageSize: CGFloat = 48
        static let imageCornerRadius: CGFloat = 8
        static let backgroundOpacity: CGFloat = 0.25
    }

    enum Toolbar {
        static let iconSize: CGFloat = 24
        static let buttonSize: CGFloat = 36
        static let shadowRadius: CGFloat = 6
        static let shadowYOffset: CGFloat = 4
    }

    enum Layout {
        static let defaultSpacing: CGFloat = 12
        static let stackViewSpacing: CGFloat = 12
        static let pageControlHeight: CGFloat = 20
        static let tableViewMinHeight: CGFloat = 400
    }

    enum Paddings {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }

    enum Stats {
        static let detentHeight: CGFloat = 200
        static let verticalSpacing: CGFloat = 12
        static let cornerRadius: CGFloat = 20
    }
}
