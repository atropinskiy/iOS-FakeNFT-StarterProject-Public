//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import Foundation

@MainActor
final class CartViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let orderId: String = "1"
    private let networkService = NetworkServiceFunction.shared

    init() {
        loadOrderNFTs()
    }
    
    func loadOrderNFTs() {
        Task {
            await fetchNFTsFromOrder()
        }
    }
    
    private func fetchNFTsFromOrder() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let order = try await networkService.fetchOrder(by: orderId)
            var loadedNFTs: [NFT] = []
            
            for nftId in order.nfts {
                let nft = try await networkService.fetchNft(with: nftId)
                loadedNFTs.append(nft)
            }
            
            self.nfts = loadedNFTs
        } catch {
            self.errorMessage = "Не удалось загрузить NFT из заказа: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
