//
//  StatsBottomSheetView.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI

struct StatsBottomSheetView: View {

    let items: [ListItem]
    let pageIndex: Int

    var body: some View {
        
        let stats = calculateStats(from: items)
        
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
    
    private func calculateStats(from items: [ListItem]) -> [(Character, Int)] {
        
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
            .prefix(3)
            .map { ($0.key, $0.value) }
    }
}
