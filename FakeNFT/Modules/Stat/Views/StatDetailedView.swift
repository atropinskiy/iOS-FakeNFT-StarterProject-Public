//
//  StatDetailedView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 06.05.2025.
//

import SwiftUI

struct StatDetailedView: View {
    @ObservedObject var viewModel: ProfileStatViewModel
    @State var user: User
    @State private var showUserSite: Bool = false
    @State var nftsInCart: [String] = []
    @State var nftsInFavorites: [String] = []

    init(user: User, statUserViewModel: ProfileStatViewModel) {
        self.viewModel = statUserViewModel
        self.user = user
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: user.avatar)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 70, height: 70)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                        @unknown default:
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                    }
                }
                Text(user.name)
                    .font(.system(size: 22, weight: .bold))
            }
            .padding(.top, 20)
            VStack(alignment: .leading, spacing: 8) {
                Text(user.description)
                    .font(.system(size: 13, weight: .regular))
                    .lineSpacing(18 - UIFont.systemFont(ofSize: 13, weight: .regular).lineHeight)
                    .tracking(-0.08)
                    .foregroundStyle(Color(.tBlack))
                    .padding(.trailing, 2)
                    .lineLimit(nil)
                Button("Перейти на сайт пользователя") {
                    showUserSite = true
                }
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(Color(.tBlack))
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color(.tWhite))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color(.tBlack), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.top, 28)

                VStack(spacing: 0) {
                    if user.nfts.count == 0 {
                        MenuRow(title: "Коллекция NFT", count: user.nfts.count, destination: EmptyNFTView(title: "Тут NFT нет", imageName: "exclamationmark.octagon", description: "В этой коллекции пока нет ни одного NFT"))
                    } else {
                        MenuRow(title: "Коллекция NFT", count: user.nfts.count, destination: NFTCollectionView(statUserViewModel: viewModel, user: $user))
                    }
                }
                .padding(.top, 40)
            }
            .padding(.top, 28)
        }
        .padding(.horizontal, 16)
        .navigationDestination(isPresented: $showUserSite) {
            UserSiteView(user: user)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonViewSimple()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            self.nftsInCart = viewModel.nftsInCart
            self.nftsInFavorites = viewModel.nftsInFavorites
        }
        Spacer()
    }
}

//#Preview("Light mode") {
//    //    let viewModel = ProfileStatDetailViewModel()
//    //    StatDetailedView(viewModel: viewModel)
//    let userViewWithImage = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: [], rating: "112", id: "1")
//    @State var nftsInCart: [String] = []
//    @State var nftsInFavorites: [String] = []
//    StatDetailedView(user: userViewWithImage, nftsInCart: $nftsInCart, nftsInFavorites: $nftsInFavorites)
//}
//
//#Preview("Dark mode") {
//    //    let viewModel = ProfileStatDetailViewModel()
//    //    StatDetailedView(viewModel: viewModel)
//    let userViewNoImage = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: [], rating: "112", id: "1")
//    @State var nftsInCart: [String] = []
//    @State var nftsInFavorites: [String] = []
//    StatDetailedView(user: userViewNoImage, nftsInCart: $nftsInCart, nftsInFavorites: $nftsInFavorites)
//        .preferredColorScheme(.dark)
//}

struct BackButtonViewSimple: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        })
        {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color(.tBlack))
        }
    }
}

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isLoading: Bool

    var body: some View {
        Button(action: {
            isLoading = false
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color(.tBlack))
        }
    }
}

struct MenuRow<Destination: View>: View {
    let title: String
    let count: Int?
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(textWithCount)
                    .foregroundStyle(Color(.tBlack))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(.tBlack))
            }
            .frame(maxHeight: 54)
        }
    }
    private var textWithCount: String {
        count.map { "\(title) (\($0))" } ?? title
    }
}
