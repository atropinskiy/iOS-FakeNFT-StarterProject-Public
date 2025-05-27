//
//  NFTCollectionItem.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import SwiftUI

struct NFTCollectionItem: View {
    @ObservedObject var viewModel: NFTCollectionViewModel
    @ObservedObject var statUserViewModel: ProfileStatViewModel
    let nftItem: NFT
    @State var inFavorites: Bool
    @State var inCart: Bool
    @State var isProcessingFavorites: Bool = false

    init(viewModel: NFTCollectionViewModel, statUserViewModel: ProfileStatViewModel, nftItem: NFT, inFavorites: Bool, inCart: Bool) {
        self.viewModel = viewModel
        self.statUserViewModel = statUserViewModel
        self.nftItem = nftItem
        self.inFavorites = inFavorites
        self.inCart = inCart
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: nftItem.images.first ?? "")) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 108, height: 108)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 108, height: 108)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            Color(.tLightGray)
                                .frame(width: 108, height: 108)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        @unknown default:
                            Color(.tLightGray)
                                .frame(width: 108, height: 108)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                Button(action: {
                    guard !isProcessingFavorites else { return }
                    isProcessingFavorites = true
                    inFavorites.toggle()
                    Task {
                        await statUserViewModel.toggleFavorites(nft: nftItem)
                        isProcessingFavorites = false
                    }
                }, label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(inFavorites ? Color(.tRedUn) : Color(.white))
                        .font(.system(size: 20))
                }
                )
                .disabled(isProcessingFavorites)
                .padding(10)
            }
            .padding(.bottom, 8)
            StatisticsStars(stars: nftItem.rating)
                .padding(.bottom, 4)
            Spacer(minLength: 0)
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(nftItem.name).font(.system(size: 17, weight: .bold)).lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(nftItem.price)" + " " + "ETH")
                        .font(.system(size: 10, weight: .regular))
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .layoutPriority(1)
                StatisticsCart(viewModel: statUserViewModel, inCart: $inCart, nftItem: nftItem)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: 108, maxHeight: 200)
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
    @ObservedObject var viewModel: ProfileStatViewModel
    @Binding var inCart: Bool
    @State var isProcessingCart: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    let nftItem: NFT

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                guard !isProcessingCart else { return }
                isProcessingCart = true
                inCart.toggle()
                Task {
                    await viewModel.toggleCart(nft: nftItem)
                    isProcessingCart = false
                }
            }, label: {
                Image(getCartImagerResource(inCart: inCart))
                    .frame(width: 40, height: 40)
            })
            .disabled(isProcessingCart)
        }
    }

    private func getCartImagerResource(inCart: Bool) -> ImageResource {
        colorScheme == .dark
        ? (inCart ? .cartCrossDark : .cartDark)
        : (inCart ? .cartCrossLight : .cartLight)
    }
}

//#Preview("Light mode") {
////    let inFavorites: Bool = false
//    let viewModel = NFTCollectionViewModel()
//    let nftItem = viewModel.mockNfts[0]
//    //    var inCart: Bool = true
////    NFTCollectionItem(viewModel: viewModel, nftItem: nftItem, nftsInFavorites: [], nftsInCart: [])
//    NFTCollectionItem(viewModel: viewModel, nftItem: nftItem)
////    NFTCollectionItem(viewModel: viewModel, nftItem: nftItem, inFavorites: false, inCart: false)
//}
//
//#Preview("Dark mode") {
//    let nftItem = NFTCollectionViewModel()
//    let viewModel = NFTCollectionViewModel()
////    @Previewable @State var inFavorites: Bool = false
////    var inCart: Bool = true
////    NFTCollectionItem(nftItem: nftItem.mockNfts[0], inFavorites: .constant(true))
//    NFTCollectionItem(viewModel: viewModel, nftItem: nftItem.mockNfts[0])
//        .preferredColorScheme(.dark)
//}
