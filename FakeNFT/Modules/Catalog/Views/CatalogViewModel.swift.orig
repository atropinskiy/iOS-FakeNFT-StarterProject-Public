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
final class CatalogViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var collectionsList: [Collection] = []
    @Published var isLoading: Bool = false
    @Published var likedNFTs: [String] = []
    @Published var cartNFTs: [String] = []
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
                self.collectionsList = collections
                self.sortCollections(&self.collectionsList)
                self.isLoading = false
            } catch {
                print("Ошибка загрузки коллекций: \(error)")
                self.isLoading = false
            }
        }
    }
<<<<<<< HEAD
    
    func fetchLikesAndCart() {
        isLoading = true
        Task {
            do {
                let profile = try await networkService.fetchProfile(id: 1)
                DispatchQueue.main.async {
                    self.likedNFTs = profile.likes
                    self.cartNFTs = profile.nfts
                    self.isLoading = false
                    print(self.likedNFTs, self.cartNFTs)
                }
            } catch {
                print("Ошибка загрузки коллекций: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    
    func addToCart(nft: String) {
        isLoading = true
        Task {
            do {
                var updatedNFTs = self.cartNFTs
                updatedNFTs.append(nft)
                print(updatedNFTs)
                _ = try await networkService.uploadNFTSToCart(by: "1", nfts: updatedNFTs)
                isLoading = false
            } catch {
                print("Ошибка добавления в корзину: \(error)")
                isLoading = false
            }
        }
    }
    
    
=======
>>>>>>> 6d5003e50b0c6d65e3b90838e9f52c670fe3c135
    private func sortCollections(_ collections: inout [Collection]) {
        switch orderType {
        case .count:
            collections.sort { $0.nfts.count > $1.nfts.count }
        case .name:
            collections.sort {
                let nameFirst = extractFileName(from: $0.cover) ?? ""
                let nameSecond = extractFileName(from: $1.cover) ?? ""
                return nameFirst.lowercased() < nameSecond.lowercased()
            }
        }
    }

    func extractFileName(from urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }
        return url.deletingPathExtension().lastPathComponent
    }
}
