//
//  CartView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

enum SortType {
    case none
    case price
    case rating
    case name
}

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    @State private var selectedNFT: NFT?
    @State private var isPaymentActive = false
    @State private var showSortOptions = false
    @State private var sortType: SortType = .none
    
    private var totalPrice: Double {
        Double(cartViewModel.nfts.reduce(0) { $0 + $1.price })
    }
    
    private var sortedNFTs: [NFT] {
        switch sortType {
        case .name:
            return cartViewModel.nfts.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        case .price:
            return cartViewModel.nfts.sorted { $0.price < $1.price }
        case .rating:
            return cartViewModel.nfts.sorted { $0.rating > $1.rating }
        case .none:
            return cartViewModel.nfts
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    if cartViewModel.nfts.isEmpty && !cartViewModel.isLoading {
                        Spacer()
                        Text("Корзина пуста")
                        Spacer()
                    } else {
                        HStack {
                            Spacer()
                            Button {
                                showSortOptions = true
                            } label: {
                                Image(.cartFilter)
                                    .frame(width: 42, height: 42)
                                    .padding(.trailing, 9)
                            }
                            .padding(.bottom, 20)
                            .confirmationDialog("Сортировка", isPresented: $showSortOptions, titleVisibility: .visible) {
                                Button("По цене") { sortType = .price }
                                Button("По рейтингу") { sortType = .rating }
                                Button("По названию") { sortType = .name }
                            }
                            .accessibilityIdentifier("cartFilter")
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
                                    ForEach(sortedNFTs) { nft in
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
                }
                .background(Color(.tWhite))
                .blur(radius: selectedNFT != nil ? 8 : 0)
                
                if let nft = selectedNFT {
                    NFTDeleteModal(nft: nft,
                                   onDelete: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            Task {
                                await cartViewModel.deleteNFTFromCart(id: nft.id)
                            }
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
                PaymentMethodView(cartViewModel: cartViewModel)
            }
            .onAppear {
                cartViewModel.loadOrderNFTs()
            }
        }
    }
}
