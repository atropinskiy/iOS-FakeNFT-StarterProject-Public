//
//  CartViewCell.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct CartViewCell: View {
    let nft: NFT
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: nft.images.first ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 108, height: 108)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 108, height: 108)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                case .failure:
                    Color.gray
                        .frame(width: 108, height: 108)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(nft.name)
                    .font(.headline)

                HStack(spacing: 2) {
                    ForEach(0..<5) { i in
                        Image(systemName: i < nft.rating ? "star.fill" : "star")
                            .foregroundColor(i < nft.rating ? .yellow : .gray)
                            .font(.caption)
                    }
                }

                Text("Цена")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("\(nft.price, specifier: "%.2f") ETH")
                    .font(.subheadline)
                    .bold()
            }

            Spacer()

            Button(action: onDelete) {
                Image("DeleteNFTFromOrder")
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let nft_1 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 1, description: "A 3D model of a mythical creature", price: 8.81, author: "Yoda", id: "1")
    
    CartViewCell(nft: nft_1, onDelete: {})
}
