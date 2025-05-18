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
                        ForEach(viewModel.nfts, id: \.self) { nft in
                            NFTCollectionItem(nftItem: nft)
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
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView(isLoading: $viewModel.isLoading)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            viewModel.setup(with: user)
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview("Light mode") {
    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "nft1")
    let nft2 = NFT(createdAt: "", name: "Emma", images: ["emma"], rating: 4, description: "", price: 1.25, author: "", id: "nft2")
    let nft3 = NFT(createdAt: "", name: "Stella", images: ["stella"], rating: 3, description: "", price: 2.5, author: "", id: "nft3")
    let nft4 = NFT(createdAt: "", name: "Toast", images: ["toast"], rating: 1, description: "", price: 1.0, author: "", id: "nft4")
    let nft5 = NFT(createdAt: "", name: "Zeus", images: ["zeus"], rating: 5, description: "", price: 3.85, author: "", id: "nft5")
    @State var user = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: ["nft1", "nft2", "nft3", "nft4", "nft5"], rating: "112", id: "1")
    NFTCollectionView(user: $user)
}

#Preview("Dark mode") {
    let nft1 = NFT(createdAt: "", name: "Archie", images: ["archie"], rating: 2, description: "", price: 1.78, author: "", id: "nft1")
    let nft2 = NFT(createdAt: "", name: "Emma", images: ["emma"], rating: 4, description: "", price: 1.25, author: "", id: "nft2")
    let nft3 = NFT(createdAt: "", name: "Stella", images: ["stella"], rating: 3, description: "", price: 2.5, author: "", id: "nft3")
    let nft4 = NFT(createdAt: "", name: "Toast", images: ["toast"], rating: 1, description: "", price: 1.0, author: "", id: "nft4")
    let nft5 = NFT(createdAt: "", name: "Zeus", images: ["zeus"], rating: 5, description: "", price: 3.85, author: "", id: "nft5")
    @State var user = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: ["nft1", "nft2", "nft3", "nft4", "nft5"], rating: "112", id: "1")
    NFTCollectionView(user: $user)
        .preferredColorScheme(.dark)
}
