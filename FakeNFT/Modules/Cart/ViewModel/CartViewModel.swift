//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import Foundation

@MainActor
final class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    @Published var nfts: [NFT]
    
    init() {
        let nft_1 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 1, description: "A 3D model of a mythical creature", price: 8.81, author: "Yoda", id: "1")
        let nft_2 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "Greena", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png"], rating: 2, description: "A 3D model of a mythical creature", price: 7.81, author: "Yoda", id: "2")
        let nft_3 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "Greena", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png"], rating: 1, description: "A 3D model of a mythical creature", price: 6.81, author: "Yoda", id: "3")
    
        self.nfts = [nft_1, nft_2, nft_3]
    }
}
