//
//  CatalogGridCell.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogGridCell: View {
    @ObservedObject var viewModel: CatalogViewModel
    private let nft: NFT
    init(viewModel: CatalogViewModel, nft: NFT) {
        self.nft = nft
        self.viewModel = viewModel
    }
    var body: some View {
        let isLiked = viewModel.profile?.likes.contains(nft.id) ?? false
        let isInCart = viewModel.cartNFTs.contains(nft.id)

        VStack {
            ZStack(alignment: .topTrailing) {
                KFImageView(
                    urlString: nft.images[0], placeholder: {ProgressView()}, cornerRadius: 12
                )
                Button(action: {
                    viewModel.toggleLike(for: nft.id)
                }, label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(isLiked ? Color(hex: "#F56B6C") : Color.white)
                        .font(.system(size: 20))
                })
                .padding(10)
            }
            .padding(.bottom, 3)
            ZStack {
                VStack(spacing: 0) {
                    CatalogStars(stars: nft.rating)
                    Text("\(nft.name.components(separatedBy: " ").first ?? "")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.top, 5)
                    Text("\(Int(ceil(nft.price))) ETH")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 10, weight: .regular))
                        .padding(.top, 5)
                }
                CatalogCartIconView(
                    inCart: isInCart,
                    toggleAction: {
                        viewModel.toggleCart(for: nft.id)
                    }
                )
            }
        }
        .frame(maxWidth: 108)
    }
}

private struct CatalogStars: View {
    private let stars: Int
    init (stars: Int) {
        self.stars = stars
    }
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .foregroundColor(index < self.stars ? Color.yellow : Color(hex: "#F7F7F8"))
                    .font(.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct CatalogCartIconView: View {
    let inCart: Bool
    let toggleAction: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button(action: toggleAction) {
                Image(inCart ? .catalogTrashCross : .catalogTrash)
                    .padding([.top, .trailing], 12)
            }
        }
    }
}
