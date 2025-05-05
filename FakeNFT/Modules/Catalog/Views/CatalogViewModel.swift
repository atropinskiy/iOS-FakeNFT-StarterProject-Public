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

enum OrderType: Hashable {
    case count
    case name
}

@MainActor
class CatalogViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var collectionsList: [Collection] = []
    @Published var isLoading: Bool = false
    @Published var orderType: OrderType = .count {
        didSet {
            sortCollections(&collectionsList)
        }
    }
    private let networkService = NetworkServiceFunction.shared
    func goTo(_ screen: AppScreen) {
        path.append(screen)
    }
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    func fetchCollections() {
        isLoading = true
        Task {
            do {
                let collections = try await networkService.fetchCollections()
                DispatchQueue.main.async {
                    self.collectionsList = collections
                    self.sortCollections(&self.collectionsList)
                    self.isLoading = false
                }
            } catch {
                print("Ошибка загрузки коллекций: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    private func sortCollections(_ collections: inout [Collection]) {
        switch orderType {
        case .count:
            collections.sort { $0.nfts.count > $1.nfts.count }
        case .name:
            collections.sort {
                let name1 = extractFileName(from: $0.cover) ?? ""
                let name2 = extractFileName(from: $1.cover) ?? ""
                return name1.lowercased() < name2.lowercased()
            }
        }
    }

    func extractFileName(from urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }
        return url.deletingPathExtension().lastPathComponent
    }
}
