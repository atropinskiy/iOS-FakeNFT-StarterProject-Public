//
//  EmptyNFTView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 27.05.2025.
//

import SwiftUI

struct EmptyNFTView: View {
    let title: String
    let imageName: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 48))
                .foregroundStyle(Color(.gray))
            Text(title)
                .font(.title2)
                .bold()
            Text(description)
                .font(.subheadline)
                .foregroundStyle(Color(.gray))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Коллекция NFT")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonViewSimple()
            }
        }
    }
}

#Preview {
    let title: String = "Тут NFT нет"
    let imageName: String = "exclamationmark.octagon"
    let description: String = "В этой коллекции пока нет ни одного NFT"
    EmptyNFTView(title: title, imageName: imageName, description: description)
}
