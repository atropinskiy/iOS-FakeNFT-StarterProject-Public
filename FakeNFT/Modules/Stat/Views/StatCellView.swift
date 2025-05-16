//
//  StatCellView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import SwiftUI

struct StatCellView: View {
//    let profile: UserModel
    let user: User
    private let statCellCornerRadius: CGFloat = 12
    private let statCellHeight: CGFloat = 80

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: statCellCornerRadius)
                .foregroundStyle(Color(.tLightGray))
            HStack {
                let cellImage = user.avatar.isEmpty ? Image(systemName: "person.circle.fill") : Image(user.avatar)
                cellImage
                    .resizable()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                Text(user.name)
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Text("\(user.rating)")
                    .font(.system(size: 22, weight: .bold))
            }
            .padding(.horizontal, 16)
        }
        .frame(height: statCellHeight)
    }
}

#Preview {
//    let profileViewWithImage = ProfileModel(avatar: "alex", name: "Alex", rating: 112, description: "", nfts: [], website: "")
//    StatCellView(profile: profileViewWithImage)
    let userViewWithImage = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "website", nfts: [], rating: "112", id: "1")
    StatCellView(user: userViewWithImage)
}

#Preview {
//    let profileViewNoImage = ProfileModel(avatar: "", name: "Bill", rating: 98, description: "", nfts: [], website: "")
//    StatCellView(profile: profileViewNoImage)
    let userViewWithImage = User(name: "Bill", avatar: "",  description: "Bill Bill Bill", website: "website", nfts: [], rating: "98", id: "2")
    StatCellView(user: userViewWithImage)
}
