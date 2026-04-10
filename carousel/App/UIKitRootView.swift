//
//  UIKitRootView.swift
//  carousel
//
//  Created by ellkaden on 06/02/26.
//

import SwiftUI
import UIKit

struct UIKitRootView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let container = AppContainer()
        return UINavigationController(
            rootViewController: container.makeMainViewController()
        )
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
