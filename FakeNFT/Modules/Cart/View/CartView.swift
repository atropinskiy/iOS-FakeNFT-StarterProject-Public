//
//  CartView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    
    var totalPrice: Double {
        Double(cartViewModel.nfts.reduce(0) { $0 + $1.price })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    // TODO: Filter action, module 3
                } label: {
                    Image("CartFilterImage")
                        .padding(.trailing, 9)
                }
                .padding(.bottom, 36)
            }
            
            // Список NFT
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    ForEach(cartViewModel.nfts) { nft in
                        CartViewCell(nft: nft) {
                            withAnimation {
                                DispatchQueue.main.async {
                                    cartViewModel.nfts.removeAll { $0.id == nft.id }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(cartViewModel.nfts.count) NFT")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.black)
                    
                    Text("\(totalPrice, specifier: "%.2f") ETH")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.green)
                }
                .padding(.leading, 16)
                
                Spacer()
                
                Button(action: {
                    // Действие при нажатии
                }) {
                    Text("К оплате")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .background(Color.black)
                .cornerRadius(16)
                .padding(.trailing, 16)
            }
            .padding(16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
        }
        .background(Color.white)
    }
}

#Preview {
    CartView()
}
