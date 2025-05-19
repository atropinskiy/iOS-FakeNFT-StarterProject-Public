//
//  CartView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    @State private var selectedNFT: NFT?
    @State private var isPaymentActive = false
    
    private var totalPrice: Double {
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
                            Image(.cartFilter)
                                .frame(width: 42, height: 42)
                                .padding(.trailing, 9)
                        }
                        .padding(.bottom, 20)
                    }
                    if cartViewModel.isLoading {
                        Spacer()
                        ProgressView("Загрузка...")
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.tBlack)))
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
                        .refreshable {
                            let start = Date()
                            try? await Task.sleep(nanoseconds: 700_000_000)
                            await cartViewModel.refresh()
                            
                            let elapsed = Date().timeIntervalSince(start)
                            if elapsed < 0.7 {
                                try? await Task.sleep(nanoseconds: UInt64((0.7 - elapsed) * 1_000_000_000))
                            }
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(cartViewModel.nfts.count) NFT")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(Color(.tBlack))
                                .accessibilityIdentifier("nftCountText")
                            
                            Text("\(totalPrice, specifier: "%.2f") ETH")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color(.tGreenUn))
                                .accessibilityIdentifier("totalPriceText")
                        }
                        .padding(.leading, 2)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                isPaymentActive = true
                            }
                        }) {
                            Text("К оплате")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color(.tWhite))
                                .frame(maxWidth: 240, minHeight: 44)
                                .accessibilityIdentifier("payButton")
                        }
                        .background(Color(.tBlack))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.trailing, 2)
                    }
                    .padding(16)
                    .background(Color(.tLightGray))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(minHeight: 76)
                }
                .background(Color(.tWhite))
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
