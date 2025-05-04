//
//  CartView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    @State private var selectedNFT: NFT? = nil
    
    var totalPrice: Double {
        Double(cartViewModel.nfts.reduce(0) { $0 + $1.price })
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        // TODO: Filter action, module 3
                    } label: {
                        Image("CartFilterImage")
                            .frame(width: 42, height: 42)
                            .padding(.trailing, 9)
                    }
                    .padding(.bottom, 20)
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        ForEach(cartViewModel.nfts) { nft in
                            NFTCellView(nft: nft) {
                                selectedNFT = nft
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(cartViewModel.nfts.count) NFT")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color("tBlack"))
                        
                        Text("\(totalPrice, specifier: "%.2f") ETH")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color("tGreenUn"))
                    }
                    .padding(.leading, 2)
                    
                    Spacer()
                    
                    Button(action: {
                        // Действие при нажатии
                    }) {
                        Text("К оплате")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: 240, minHeight: 44)
                    }
                    .background(Color("tBlack"))
                    .cornerRadius(16)
                    .padding(.trailing, 2)
                }
                .padding(16)
                .background(Color("tLightGray"))
                .cornerRadius(16)
                .frame(minHeight: 76)
            }
            .background(Color.white)
            .blur(radius: selectedNFT != nil ? 8 : 0)
            
            if let nft = selectedNFT {
                NFTDeleteModal(nft: nft,
                               onDelete: {
                    cartViewModel.nfts.removeAll { $0.id == nft.id }
                    selectedNFT = nil
                }, onCancel: {
                    selectedNFT = nil
                }
                )
            }
        }
    }
}

#Preview {
    CartView()
}
