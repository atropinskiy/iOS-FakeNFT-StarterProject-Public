//
//  NFTCollectionView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import SwiftUI

struct NFTCollectionView: View {
    @StateObject private var viewModel = NFTCollectionViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @Binding var user: User
    @Binding var nftsInCart: [String]
    @Binding var nftsInFavorites: [String]

//    @State private var inFavorites: Bool = false
//    @State private var isLoading: Bool = false

    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Подгружаем NFT...")
                }
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 8
                    ) {
                        ForEach(viewModel.nfts, id: \.id) { nft in
//                            print(viewModel.isInFavorites(nft: nft))
//                            print("in forEach")
//                            let _ = debugPrint("Debug:", inCart, inFavorites)
//                            viewModel.isInFavorites(nft: nft)
                            NFTCollectionItem(viewModel: viewModel, nftItem: nft)
                                .onAppear {
                                    let inCart: Bool = viewModel.isInCart(nft, nftInCart: nftsInCart)
                                    let inFavorites: Bool = viewModel.isInFavorites(nft, nftInFavorite: nftsInFavorites)
                                    if inCart {
                                        let _ = debugPrint("Debug inCart - в Корзине:", nft.id, nft.name)
                                    }
                                    if inFavorites {
                                        let _ = debugPrint("Debug inFavorites - в Избранном:", nft.id, nft.name)
                                    }

                                }
//                            NFTCollectionItem(nftItem: nft, nftsInCart: $nftsInCart, nftsInFavorites: $nftsInFavorites)
//                            NFTCollectionItem(viewModel: viewModel, nftItem: nft, inCart: inCart, inFavorites: inFavorites)
//                            NFTCollectionItem(viewModel: viewModel, nftItem: nft, inCart: viewModel.isInCart(nft, nftInCart: nftsInCart), inFavorites: viewModel.isInFavorites(nft, nftInFavorite: nftsInFavorites))
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 16)
                .ignoresSafeArea(edges: .horizontal)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("Коллекция NFT")
//        .navigationBarBackButtonHidden(true)
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                BackButtonView(isLoading: $viewModel.isLoading)
//            }
//        }
        .onAppear {
            viewModel.setup(with: user)
            Task { @MainActor in
                await viewModel.fetchData()
            }
        }
    }
}

//#Preview("Light mode") {
//    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "nft1")
//    let nft2 = NFT(createdAt: "", name: "Emma", images: ["emma"], rating: 4, description: "", price: 1.25, author: "", id: "nft2")
//    let nft3 = NFT(createdAt: "", name: "Stella", images: ["stella"], rating: 3, description: "", price: 2.5, author: "", id: "nft3")
//    let nft4 = NFT(createdAt: "", name: "Toast", images: ["toast"], rating: 1, description: "", price: 1.0, author: "", id: "nft4")
//    let nft5 = NFT(createdAt: "", name: "Zeus", images: ["zeus"], rating: 5, description: "", price: 3.85, author: "", id: "nft5")
//    @State var user = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: ["nft1", "nft2", "nft3", "nft4", "nft5"], rating: "112", id: "1")
//    @State var nftsInCart: [String] = []
//    @State var nftsInFavorites: [String] = []
//    NFTCollectionView(user: $user, nftsInCart: $nftsInCart, nftsInFavorites: $nftsInFavorites)
//}
//
//#Preview("Dark mode") {
//    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "nft1")
//    let nft2 = NFT(createdAt: "", name: "Emma", images: ["emma"], rating: 4, description: "", price: 1.25, author: "", id: "nft2")
//    let nft3 = NFT(createdAt: "", name: "Stella", images: ["stella"], rating: 3, description: "", price: 2.5, author: "", id: "nft3")
//    let nft4 = NFT(createdAt: "", name: "Toast", images: ["toast"], rating: 1, description: "", price: 1.0, author: "", id: "nft4")
//    let nft5 = NFT(createdAt: "", name: "Zeus", images: ["zeus"], rating: 5, description: "", price: 3.85, author: "", id: "nft5")
//    @State var user = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: ["nft1", "nft2", "nft3", "nft4", "nft5"], rating: "112", id: "1")
//    @State var nftsInCart: [String] = []
//    @State var nftsInFavorites: [String] = []
//    NFTCollectionView(user: $user, nftsInCart: $nftsInCart, nftsInFavorites: $nftsInFavorites)
//        .preferredColorScheme(.dark)
//}
