//
//  ContentView.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel: MainViewModel
    @State private var showStats = false
    
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: StyleGuide.Layout.carouselToListSpacing) {
                    HStack {
                        Spacer(minLength: 0)
                        Button {
                            showStats = true
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: StyleGuide.Toolbar.iconSize, weight: .medium))
                                .symbolRenderingMode(.monochrome)
                                .rotationEffect(.degrees(90))
                                .foregroundStyle(.white)
                                .frame(width: StyleGuide.Toolbar.buttonSize,
                                       height: StyleGuide.Toolbar.buttonSize)
                                .background(Color(uiColor: .systemBlue))
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(StyleGuide.Toolbar.shadowOpacity),
                                        radius: StyleGuide.Toolbar.shadowRadius,
                                        x: 0,
                                        y: StyleGuide.Toolbar.shadowYOffset)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, StyleGuide.Layout.horizontalPadding)
                    .padding(.top, 8)
                    .padding(.bottom, StyleGuide.Toolbar.buttonToCarouselSpacing)

                    CarouselView(
                        pages: viewModel.pages,
                        currentPage: $viewModel.currentPage
                    )

                    ItemsListView(items: viewModel.filteredItems)
                        .padding(.horizontal)
                        .padding(.bottom, StyleGuide.SearchBar.height + StyleGuide.Layout.bottomSearchBarPadding + StyleGuide.Layout.listToSearchBarSpacing)
                }
            }
            
            .task {
                await viewModel.load()
            }

            HStack(spacing: 20) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: StyleGuide.SearchBar.iconSize))
                    .foregroundStyle(.secondary)
                TextField("Search", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
            }
            .padding(.horizontal, StyleGuide.SearchBar.horizontalPadding)
            .frame(height: StyleGuide.SearchBar.height)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: StyleGuide.SearchBar.cornerRadius))
            .shadow(color: .black.opacity(StyleGuide.SearchBar.shadowOpacity),
                    radius: StyleGuide.SearchBar.shadowRadius,
                    x: 0,
                    y: StyleGuide.SearchBar.shadowYOffset)
            .padding(.horizontal, StyleGuide.Layout.horizontalPadding)
            .padding(.bottom, StyleGuide.Layout.bottomSearchBarPadding)
        }
        .sheet(isPresented: $showStats) {
            StatsBottomSheetView(
                items: viewModel.filteredItems,
                pageIndex: viewModel.currentPage
            )
        }
    }
}


#Preview {
    ContentView(
        viewModel: MainViewModel(
            repository: CarouselRepositoryImpl()
        )
    )
}
