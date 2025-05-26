//
//  NFTCollectionViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import Foundation
import Combine

final class NFTCollectionViewModel: ObservableObject {
    @Published var showStatus: Int = 0
    @Published var nfts: [NFT] = []
    @Published var mockNfts: [NFT] = []
    //    @Published var nfts: [NFTElementModel] = []
    @Published var isLoading: Bool = false
//    @Published private var nftsInFavorites: [String] = []
//    private var nftsInCart: [String] = []
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
        //        self.nfts = user.nfts
        self.mockNfts = [nft1, nft2, nft3, nft4, nft5]
        //        $orderByName
        //            .map { [weak self] _ in
        //                guard let self else { return [] }
        //                return self.nfts.sorted { $0.name < $1.name}
        //            }
        //            .sink { [weak self] nfts in
        //                self?.nfts = nfts
        //            }
        //            .store(in: &cancellableSet)
    }

    func setup(with user: User) {
        self.userNFTIDs = user.nfts
    }

    //    func fetch() {
    //        isLoading = true
    //        Just(nfts)
    //            .delay(for: 2, scheduler: RunLoop.main)
    //            .map { $0 }
    //            .sink { [weak self] nfts in
    //                self?.nfts = nfts
    //                self?.isLoading = false
    //            }
    //            .store(in: &cancellableSet)
    //    }

 @MainActor
    func fetchData() async {
//        print("Step 1 - Начинаю качать список NFT пользователя...")
        //        profileArray = [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
//        print("userNFTIDs", userNFTIDs)
        guard !userNFTIDs.isEmpty else { return }
//        Task { @MainActor in
            self.isLoading = true
//        }
        nfts.removeAll()
//        print("Step 2 - Начинаю качать список NFT пользователя...")
        let publishers = userNFTIDs.map { id in
            Future<NFT, Error> { [weak self] promise in
                guard let self else { return }
                Task {
                    do {
//                        print("Скачиваю NFT с id \(id)...")
                        let nft = try await self.networkService.fetchNft(with: id)
//                        print("Имя NFT: \(nft.name)")
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
//                print("NFT count: \(nfts.count)")
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
