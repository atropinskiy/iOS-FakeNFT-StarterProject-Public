//
//  CartView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    @State private var selectedNFT: NFT? = nil
    @State private var isPaymentActive = false
    
    var totalPrice: Double {
        Double(cartViewModel.nfts.reduce(0) { $0 + $1.price })
    }
    
    var body: some View {
        NavigationStack {
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
                    if cartViewModel.isLoading {
                        Spacer()
                        ProgressView("Загрузка...")
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("tBlack")))
                            .padding(.top, 50)
                        Spacer()
                    } else {
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
                            withAnimation {
                                isPaymentActive = true
                            }
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
                        withAnimation(.easeInOut(duration: 0.3)) {
                            cartViewModel.nfts.removeAll { $0.id == nft.id }
                            selectedNFT = nil
                        }
                    }, onCancel: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedNFT = nil
                        }
                    })
                    
                    .zIndex(1)
                }
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .navigationDestination(isPresented: $isPaymentActive) {
                PaymentMethodView()
            }
        }
    }
}

#Preview {
    CartView()
}
