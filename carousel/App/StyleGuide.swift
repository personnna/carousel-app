//
//  carouselApp.swift
//  carousel
//
//  Created by ellkaden on 17/02/26.
//

import SwiftUI

enum StyleGuide {

    enum Carousel {
        static let height: CGFloat = 180
        static let horizontalPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let shadowRadius: CGFloat = 6
        static let shadowYOffset: CGFloat = 4
        static let pageIndicatorSize: CGFloat = 8
        static let pageIndicatorSpacing: CGFloat = 10
        static let pageIndicatorTopPadding: CGFloat = 16
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
        static let buttonSize: CGFloat = 36
        static let iconSize: CGFloat = 20
        static let buttonToCarouselSpacing: CGFloat = 12
        static let shadowOpacity: Double = 0.2
        static let shadowRadius: CGFloat = 4
        static let shadowYOffset: CGFloat = 2
    }

    enum Stats {
        static let detentHeight: CGFloat = 180
        static let verticalSpacing: CGFloat = 12
    }

    enum Layout {
        static let defaultVStackSpacing: CGFloat = 12
        static let carouselToListSpacing: CGFloat = 20
        static let horizontalPadding: CGFloat = 16
        static let bottomSearchBarPadding: CGFloat = 24
        static let listToSearchBarSpacing: CGFloat = 20
    }

    enum SearchBar {
        static let height: CGFloat = 44
        static let cornerRadius: CGFloat = 22
        static let horizontalPadding: CGFloat = 16
        static let iconSize: CGFloat = 16
        static let shadowOpacity: Double = 0.15
        static let shadowRadius: CGFloat = 8
        static let shadowYOffset: CGFloat = 2
    }
}

