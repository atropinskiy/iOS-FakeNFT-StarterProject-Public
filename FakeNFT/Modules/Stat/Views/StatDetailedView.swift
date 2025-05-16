//
//  StatDetailedView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 06.05.2025.
//

import SwiftUI

struct StatDetailedView: View {
    let viewModel: ProfileStatDetailViewModel
    @State private var showUserSite: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(viewModel.profileDetails.avatar)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .padding(.trailing, 16)
                Text(viewModel.profileDetails.name)
                    .font(.system(size: 22, weight: .bold))
            }
            .padding(.top, 20)
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.profileDetails.description)
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
                    MenuRow(title: "Коллекция NFT", count: 112, destination: NFTCollectionView())
                }
                .padding(.top, 40)

            }
            .padding(.top, 28)
        }
        .padding(.horizontal, 16)
        .navigationDestination(isPresented: $showUserSite) {
            UserSiteView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        Spacer()
    }
}

#Preview("Light mode") {
    let viewModel = ProfileStatDetailViewModel()
    StatDetailedView(viewModel: viewModel)
}

#Preview("Dark mode") {
    let viewModel = ProfileStatDetailViewModel()
    StatDetailedView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}

struct BackButtonView: View {
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
