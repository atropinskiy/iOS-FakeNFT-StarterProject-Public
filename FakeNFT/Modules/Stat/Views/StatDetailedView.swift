//
//  StatDetailedView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 06.05.2025.
//

import SwiftUI

struct StatDetailedView: View {
    let viewModel: ProfileStatDetailViewModel

    var body: some View {
        NavigationStack {
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
                        print("Переход на сайт пользователя")
                    }
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color("tBlack"))
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color("tWhite"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color(.tBlack), lineWidth: 1)
                    )
                    .cornerRadius(16)
                    .padding(.top, 28)

                    VStack(spacing: 0) {
                        MenuRow(title: "Коллекция NFT", count: 112, destination: NFTCollectionView())
                    }
                    .padding(.top, 40)

                }
                .padding(.top, 28)
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
            }
            Text("")
                .toolbar(.hidden, for: .tabBar)
            Spacer()
        }
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
                .foregroundColor(Color(.tBlack))
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
                if let count {
                    Text(title + " " + "(\(count))")
                        .foregroundStyle(Color(.tBlack))
                        .fontWeight(.semibold)
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(.tBlack))
            }
            .frame(maxHeight: 54)
        }
//        .buttonStyle(PlainButtonStyle()) // убирает эффект затемнения
    }
}
