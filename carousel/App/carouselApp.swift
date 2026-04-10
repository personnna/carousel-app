//
//  carouselApp.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI

@main
struct CarouselApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: MainViewModel(
                    repository: CarouselRepositoryImpl()
                )
            )
        }
    }
}
