//
//  CarouselView.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI

struct CarouselView: View {

    let pages: [[ListItem]]
    @Binding var currentPage: Int

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    if let firstItem = page.first {
                        Image("img")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: StyleGuide.Carousel.height)
                            .clipped()
                            .cornerRadius(StyleGuide.Carousel.cornerRadius)
                            .padding(.horizontal, StyleGuide.Carousel.horizontalPadding)
                            .tag(index)
                            .shadow(color: .black.opacity(0.15),
                                    radius: StyleGuide.Carousel.shadowRadius,
                                    y: StyleGuide.Carousel.shadowYOffset)
                    }
                }
            }
            .frame(height: StyleGuide.Carousel.height)
            .tabViewStyle(.page(indexDisplayMode: .never))

            HStack(spacing: StyleGuide.Carousel.pageIndicatorSpacing) {
                ForEach(0..<pages.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage
                              ? Color(uiColor: .systemBlue)
                              : Color(uiColor: .systemGray4))
                        .frame(width: StyleGuide.Carousel.pageIndicatorSize,
                               height: StyleGuide.Carousel.pageIndicatorSize)
                }
            }
            .padding(.top, StyleGuide.Carousel.pageIndicatorTopPadding)
        }
    }
}

