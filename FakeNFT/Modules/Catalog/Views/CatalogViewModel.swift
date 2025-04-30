//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//
import SwiftUI

enum AppScreen: Hashable {
    case mainCatalog
    case collectionCatalog
    case authorCatalog
    case nftCard
}

class CatalogViewModel: ObservableObject {
    @Published var path = NavigationPath()
    
    func goTo(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
