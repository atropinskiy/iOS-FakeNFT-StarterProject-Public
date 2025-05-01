//
//  StatCellView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import SwiftUI

struct StatCellView: View {
    let screenSize = UIScreen.main.bounds
    var profile: ProfileModel

    var body: some View {
        let statCellCornerRadius: CGFloat = 12
        let statCellHeight: CGFloat = 80
//        let image = profile.avatar

        ZStack {
            RoundedRectangle(cornerRadius: statCellCornerRadius)
                .foregroundStyle(Color(.lightGray))
            HStack {
                if profile.avatar == "" {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                } else {
                    Image(profile.avatar)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                }
                Text(profile.name)
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Text("\(profile.rating)")
                    .font(.system(size: 22, weight: .bold))
                //                }
            }
            .padding(.horizontal, 16)
        }
//        .padding(.horizontal, 10)
        .frame(height: statCellHeight)
//        .frame(width: screenSize.size.width,
//               height: statCellHeight)
    }

}

#Preview {
    let profileView1 = ProfileModel(id: UUID(), avatar: "alex", name: "Alex", rating: 112)
    StatCellView(profile: profileView1)
}

#Preview {
    let profileView1 = ProfileModel(id: UUID(), avatar: "", name: "Bill", rating: 98)
    StatCellView(profile: profileView1)
}
