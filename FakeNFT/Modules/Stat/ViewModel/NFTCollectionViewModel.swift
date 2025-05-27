//
//  NFTCollectionViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import Foundation
import Combine

@MainActor
final class NFTCollectionViewModel: ObservableObject {
    @Published var showStatus: Int = 0
    @Published var nfts: [NFT] = []
    @Published var mockNfts: [NFT] = []
    @Published var isLoading: Bool = false
    private let networkService = NetworkServiceFunction.shared
    private var userNFTIDs: [String] = []
    private var cancellableSet: Set<AnyCancellable> = []

    //    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "")
    //    let nft1 = NFTElementModel(name: "Archie", image: "nftArchie", rating: 2, price: 1.78, isFavorite: false)
    //    let nft2 = NFTElementModel(name: "Emma", image: "nftEmma", rating: 4, price: 1.25, isFavorite: false)
    //    let nft3 = NFTElementModel(name: "Stella", image: "nftStella", rating: 3, price: 2.5, isFavorite: false)
    //    let nft4 = NFTElementModel(name: "Toast", image: "nftToast", rating: 1, price: 1.0, isFavorite: false)
    //    let nft5 = NFTElementModel(name: "Zeus", image: "nftZeus", rating: 5, price: 3.85, isFavorite: false)

    //    let nft1 = NFT(createdAt: "", name: "Carmine Cervantez", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 2, description: "", price: 1.78, author: "", id: "1")
    let nft1 = NFT(createdAt: "", name: "Archie", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 2, description: "", price: 1.78, author: "", id: "1")
    //    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "1")
    let nft2 = NFT(createdAt: "", name: "Emma", images: ["emma"], rating: 4, description: "", price: 1.25, author: "", id: "2")
    let nft3 = NFT(createdAt: "", name: "Stella", images: ["stella"], rating: 3, description: "", price: 2.5, author: "", id: "3")
    let nft4 = NFT(createdAt: "", name: "Toast", images: ["toast"], rating: 1, description: "", price: 1.0, author: "", id: "4")
    let nft5 = NFT(createdAt: "", name: "Zeus", images: ["zeus"], rating: 5, description: "", price: 3.85, author: "", id: "5")

    init() {
        self.mockNfts = [nft1, nft2, nft3, nft4, nft5]
    }

    func setup(with user: User) {
        self.userNFTIDs = user.nfts
    }

    func fetchData() async {
        guard !userNFTIDs.isEmpty else { return }
            self.isLoading = true
        nfts.removeAll()
        let publishers = userNFTIDs.map { id in
            Future<NFT, Error> { [weak self] promise in
                guard let self else { return }
                Task {
                    do {
                        let nft = try await self.networkService.fetchNft(with: id)
                        promise(.success(nft))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Ошибка: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] nfts in
                self?.nfts = nfts.sorted { $0.id < $1.id }
            }
            .store(in: &cancellableSet)
    }

    func isInFavorites(_ nft: NFT, nftInFavorite: [String]) -> Bool {
        return nftInFavorite.contains { $0 == nft.id }
    }

    func isInCart(_ nft: NFT, nftInCart: [String]) -> Bool {
        return nftInCart.contains { $0 == nft.id }
    }
}
