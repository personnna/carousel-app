//
//  StatsBottomSheetView.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI

struct StatsBottomSheetView: View {
    
    private var statsService: StatsProviding = StatsService()

    let items: [ListItem]
    let pageIndex: Int

    var body: some View {
        
        let stats = statsService.topCharacters(from: items, limit: 3)
        
        VStack(spacing: StyleGuide.Stats.verticalSpacing) {
            Text("Page \(pageIndex + 1)")
                .font(.headline)

            Text("Items count: \(items.count)")
                .font(.subheadline)

            ForEach(stats, id: \.0) { char, count in
                Text("\(char) = \(count)")
                    .font(.subheadline)
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial)
        .presentationDetents([.height(StyleGuide.Stats.detentHeight)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(16)
    }
    
    init(
        items: [ListItem],
        pageIndex: Int,
        statsService: StatsProviding = StatsService()
    ) {
        self.items = items
        self.pageIndex = pageIndex
        self.statsService = statsService
    }
}
