//
//  ItemsListView.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI

struct ItemsListView: View {

    let items: [ListItem]

    var body: some View {
        LazyVStack(spacing: StyleGuide.List.itemSpacing) {
            ForEach(items) { item in
                HStack(spacing: StyleGuide.List.itemSpacing) {

                    Image(item.imageName.isEmpty ? "img" : item.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: StyleGuide.List.imageSize,
                               height: StyleGuide.List.imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: StyleGuide.List.imageCornerRadius))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.headline)
                            .foregroundStyle(Color(uiColor: .label))

                        Text(item.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }

                    Spacer()
                }
                .padding(StyleGuide.List.itemPadding)
                .background(Color.green.opacity(StyleGuide.List.backgroundOpacity))
                .clipShape(RoundedRectangle(cornerRadius: StyleGuide.List.itemCornerRadius))
            }
        }
    }
}
