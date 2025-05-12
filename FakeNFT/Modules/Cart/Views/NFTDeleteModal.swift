//
//  NFTDeleteModal.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import SwiftUI

struct NFTDeleteModal: View {
    let nft: NFT
    let onDelete: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                VStack (spacing: 12) {
                    AsyncImage(url: URL(string: nft.images.first ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 108, height: 108)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 108, height: 108)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            Color(.tGrayUn)
                                .frame(width: 108, height: 108)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text("Вы уверены, что хотите удалить объект из корзины ?")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color(.tBlack))
                        .multilineTextAlignment(.center)
                }
                
                HStack(spacing: 8) {
                    Button("Удалить") {
                        onDelete()
                    }
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color(.tRedUn))
                    .padding()
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color(.tBlack))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityIdentifier("deleteButton")
                    
                    Button("Вернуться") {
                        onCancel()
                    }
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color(.tWhite))
                    .padding()
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color(.tBlack))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityIdentifier("cancelButton")
                }
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(40)
        }
    }
}

#Preview {
    let nft_1 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 1, description: "A 3D model of a mythical creature", price: 8.81, author: "Yoda", id: "1")
    
    NFTDeleteModal(nft: nft_1, onDelete: {}, onCancel: {})
}
