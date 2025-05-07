//
//  NFTCollectionViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import Foundation

final class NFTCollectionViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var nfts: [NFTElementModel] = []

//    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "")
    let nft1 = NFTElementModel(name: "Archie", image: "archie", rating: 2, price: 1.78, isLiked: false)
    let nft2 = NFTElementModel(name: "Emma", image: "archie", rating: 2, price: 1.78, isLiked: false)
    let nft3 = NFTElementModel(name: "Stella", image: "stella", rating: 2, price: 1.78, isLiked: false)
    let nft4 = NFTElementModel(name: "Toast", image: "toast", rating: 2, price: 1.78, isLiked: false)
    let nft5 = NFTElementModel(name: "Zeus", image: "zeus", rating: 2, price: 1.78, isLiked: false)

    init() {
        self.nfts = [nft1, nft2, nft3, nft4, nft5]
    }
}
