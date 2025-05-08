//
//  NFTCollectionView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import SwiftUI

struct NFTCollectionView: View {
    @StateObject var viewModel = NFTCollectionViewModel()
    @Environment(\.colorScheme) private var colorScheme

    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 8
            ) {
                ForEach(viewModel.nfts, id: \.self) { nft in
                    NFTCollectionItem(nftItem: nft)
                }
            }
            .padding(.top, 20)
                    .navigationTitle("Коллекция NFT")
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            BackButtonView()
                        }
                    }
                    Text("")
                        .toolbar(.hidden, for: .tabBar)
                    Spacer()
//            .border(.green)
        }
        .padding(.horizontal, 16)
        .edgesIgnoringSafeArea(.horizontal)
        .scrollContentBackground(.hidden)
    }
}

#Preview("Light mode") {
    NFTCollectionView()
}

#Preview("Dark mode") {
    NFTCollectionView()
        .preferredColorScheme(.dark)
}
