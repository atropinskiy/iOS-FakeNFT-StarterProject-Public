//
//  DeleteNFTModal.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct DeleteNFTModal: View {
    let nft: NFT
    let onDelete: () -> Void
    let onCancel: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                AsyncImage(url: URL(string: nft.images.first ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 120, height: 120)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .cornerRadius(16)
                    case .failure:
                        Color.gray
                            .frame(width: 120, height: 120)
                            .cornerRadius(16)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text("Вы уверены, что хотите удалить объект из корзины ?")
                                    .multilineTextAlignment(.center)

                HStack(spacing: 20) {
                    Button("Удалить") {
                        onDelete()
                    }
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(12)
                    
                    Button("Вернуться") {
                        onCancel()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(12)

                    
                }
            }
            .padding()
//            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(40)
        }
    }
}

#Preview {
    let nft_1 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 1, description: "A 3D model of a mythical creature", price: 8.81, author: "Yoda", id: "1")
    
    DeleteNFTModal(nft: nft_1, onDelete: {}, onCancel: {})
}

