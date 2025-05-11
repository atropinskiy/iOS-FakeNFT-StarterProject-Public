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
    @Published var currentCollectionNfts: [NFT] = []
    @Published var profile: Profile?
    @Published var orderType: OrderType = .count {
        didSet {
            sortCollections(&collectionsList)
        }
    }
    private let networkService = NetworkServiceFunction.shared

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
    func fetchLikesAndCart() {
        isLoading = true
        Task {
            do {
                let profile = try await networkService.fetchProfile(id: 1)
                self.profile = profile
                self.likedNFTs = profile.likes
                self.cartNFTs = profile.nfts
                self.isLoading = false
                print(self.likedNFTs, self.cartNFTs)
            } catch {
                print("Ошибка загрузки профиля: \(error)")
                self.isLoading = false
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
                print("Ошибка добавления в корзину NFT: \(error)")
                isLoading = false
            }
        }
    }
    func fetchAllNFTs(ids: [String]) {
        isLoading = true
        Task {
            var fetchedNFTs: [NFT] = []

            await withTaskGroup(of: NFT?.self) { group in
                for id in ids {
                    group.addTask {
                        do {
                            return try await self.networkService.fetchNft(with: id)
                        } catch {
                            print("Ошибка загрузки NFT с id \(id): \(error)")
                            return nil
                        }
                    }
                }

                for await nft in group {
                    if let nft = nft {
                        fetchedNFTs.append(nft)
                    }
                }
            }
            print("Загруженные NFT: \(fetchedNFTs)")
            self.currentCollectionNfts = fetchedNFTs
            isLoading = false
        }
    }
    func toggleLike(for id: String) {
        if profile?.likes.contains(id) == true {
            profile?.likes.removeAll { $0 == id }
        } else {
            profile?.likes.append(id)
        }

        Task {
            guard let profile = self.profile else {
                print("Ошибка: профиль не найден")
                return
            }

            do {
                let success = try await networkService.putLike(profile: profile)
                print("Результат: \(success)")
            } catch {
                print("Ошибка: \(error)")
            }
        }
    }

    func toggleCart(for id: String) {
        if cartNFTs.contains(id) {
            cartNFTs.removeAll { $0 == id }
        } else {
            cartNFTs.append(id)
        }
        Task {
            do {
                print(cartNFTs)
                let success = try await networkService.uploadNFTSToCart(by: "1", nfts: cartNFTs)
                print("Результат: \(success)")
            } catch {
                print("Ошибка: \(error)")
            }
        }
    }
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
