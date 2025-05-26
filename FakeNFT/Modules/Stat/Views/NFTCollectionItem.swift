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
                    inFavorites.toggle()
//                    viewModel.toggleFavorites(nft: nftItem, favorites: &nftsInFavorites)
                    print("inFavorites", inFavorites)
                    Task {
                        await statUserViewModel.toggleFavorites(nft: nftItem)
                    }
//                    viewModel.showStatus = 1
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
                StatisticsCart(viewModel: viewModel, inCart: $inCart)
            }
            .padding(.bottom, 20)
        }
//        .onChange(of: viewModel.showStatus) { newValue in
//            print("Status updated: \(newValue)")
//        }
//        .onReceive(viewModel.$showStatus.dropFirst()) { newValue in
//            print("Status updated: \(newValue)")
//        }
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
    @ObservedObject var viewModel: NFTCollectionViewModel
    @Binding var inCart: Bool
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                inCart.toggle()
                print("inCart", inCart)
//                viewModel.showStatus = 2
//                viewModel.toggleFavorites(nft: nftItem, favorites: &nftsInFavorites)
            }, label: {
                Image(getCartImagerResource(inCart: inCart))
                    .frame(width: 40, height: 40)
            })
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
