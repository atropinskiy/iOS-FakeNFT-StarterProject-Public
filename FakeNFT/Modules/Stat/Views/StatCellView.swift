//
//  StatCellView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import SwiftUI

struct StatCellView: View {
    let profile: ProfileModel
    private let statCellCornerRadius: CGFloat = 12
    private let statCellHeight: CGFloat = 80

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: statCellCornerRadius)
                .foregroundStyle(Color(.tLightGray))
            HStack {
                let cellImage = profile.avatar.isEmpty ? Image(systemName: "person.circle.fill") : Image(profile.avatar)
                cellImage
                    .resizable()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                Text(profile.name)
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Text("\(profile.rating)")
                    .font(.system(size: 22, weight: .bold))
            }
            .padding(.horizontal, 16)
        }
        .frame(height: statCellHeight)
    }
}

#Preview {
    let profileViewWithImage = ProfileModel(avatar: "alex", name: "Alex", rating: 112, description: "", nfts: [], website: "")
    StatCellView(profile: profileViewWithImage)
}

#Preview {
    let profileViewNoImage = ProfileModel(avatar: "", name: "Bill", rating: 98, description: "", nfts: [], website: "")
    StatCellView(profile: profileViewNoImage)
}
