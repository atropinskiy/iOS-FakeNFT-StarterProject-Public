//
//  NFTCollectionItem.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import SwiftUI

struct NFTCollectionItem: View {
    @State private var inFavorites: Bool = false
    @State private var inCart: Bool = true
    let nftItem: NFTElementModel
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(nftItem.image)
                    .resizable()
                    .frame(width: 108, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Button(action: {
                    inFavorites.toggle()
                }, label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(inFavorites ? Color(.tRedUn) : Color(.white))
                        .font(.system(size: 20))
                })
                .padding(10)
            }
            .padding(.bottom, 8)
            StatisticsStars(stars: nftItem.rating)
                .padding(.bottom, 4)
            HStack {
                VStack(spacing: 0) {
                    Text(nftItem.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17, weight: .bold))
                    Text("\(nftItem.price)" + " " + "ETH")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 10, weight: .regular))
                        .padding(.top, 4)
                }
                StatisticsCart(inCart: $inCart)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: 108)
    }
}

private struct StatisticsStars: View {
    private let stars: Int
    init (stars: Int) {
        self.stars = stars
    }
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .foregroundStyle(index < self.stars ? Color(.tYellowUn) : Color(.tLightGray))
                    .font(.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct StatisticsCart: View {
    @Binding var inCart: Bool
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                inCart.toggle()
            }, label: {
                Image(getCartImagerResource(inCart: inCart))
                    .frame(width: 40, height: 40)
            })
        }
    }

    private func getCartImagerResource(inCart: Bool) -> ImageResource {
        colorScheme == .dark
        ? (inCart ? .cartDark : .cartCrossDark)
        : (inCart ? .cartLight : .cartCrossLight)
    }
}

#Preview("Light mode") {
    let nftItem = NFTCollectionViewModel()
    var inFavorites: Bool = false
    var inCart: Bool = true
    NFTCollectionItem(nftItem: nftItem.nft1)
}

#Preview("Dark mode") {
    let nftItem = NFTCollectionViewModel()
    var inFavorites: Bool = false
    var inCart: Bool = true
    NFTCollectionItem(nftItem: nftItem.nft2)
        .preferredColorScheme(.dark)
}
