//
//  NFTCellView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import SwiftUI

struct NFTCellView: View {
    let nft: NFT
    let onDeleteTaped: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
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
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure:
                    Color.gray
                        .frame(width: 108, height: 108)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(nft.name)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("tBlack"))
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < nft.rating ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(i < nft.rating ? .yellow : .gray)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Цена")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color("tBlack"))
                    
                    Text("\(nft.price, specifier: "%.2f") ETH")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("tBlack"))
                }
            }
            
            Spacer()
            
            Button(action: {
                onDeleteTaped()
            }) {
                Image("DeleteNFTFromOrder")
                    .foregroundColor(Color("tBlack"))
                    .frame(width: 40, height: 40)
            }
        }
    }
}

#Preview {
    let nft_1 = NFT(createdAt: "2023-04-20T02:22:27Z", name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 1, description: "A 3D model of a mythical creature", price: 8.81, author: "Yoda", id: "1")
    
    NFTCellView(nft: nft_1, onDeleteTaped: {})
}
