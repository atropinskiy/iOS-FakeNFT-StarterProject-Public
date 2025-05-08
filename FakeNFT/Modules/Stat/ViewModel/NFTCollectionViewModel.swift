//
//  NFTCollectionViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import Foundation

final class NFTCollectionViewModel: ObservableObject {
//    @Published var nfts: [NFT] = []
    @Published var nfts: [NFTElementModel] = []

//    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "")
    let nft1 = NFTElementModel(name: "Archie", image: "nftArchie", rating: 2, price: 1.78, isFavorite: false)
    let nft2 = NFTElementModel(name: "Emma", image: "nftEmma", rating: 4, price: 1.25, isFavorite: false)
    let nft3 = NFTElementModel(name: "Stella", image: "nftStella", rating: 3, price: 2.5, isFavorite: false)
    let nft4 = NFTElementModel(name: "Toast", image: "nftToast", rating: 1, price: 1.0, isFavorite: false)
    let nft5 = NFTElementModel(name: "Zeus", image: "nftZeus", rating: 5, price: 3.85, isFavorite: false)

    init() {
        self.nfts = [nft1, nft2, nft3, nft4, nft5]
    }
}
