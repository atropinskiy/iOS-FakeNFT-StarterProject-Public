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
    @Published var cartEditionError: String?
    
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
    
    func refresh() async {
            await fetchNFTsFromOrder()
    }
    
    func deleteNFTFromCart(id: String) async {
        let updatedNFTs = nfts.filter { $0.id != id }
        let updatedNFTIDs = updatedNFTs.map { $0.id }
        
        await editCart(newNFTSArray: updatedNFTIDs)
        nfts = updatedNFTs
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
            
            nfts = loadedNFTs
        } catch {
            errorMessage = "Не удалось загрузить NFT из заказа: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func editCart(newNFTSArray: [String]) async {
        do {
            let order = try await networkService.uploadNFTSToCart(by: orderId, nfts: newNFTSArray)
            print("Order updated: \(order)")
        } catch {
            cartEditionError = "Ошибка удаления из корзины: \(error.localizedDescription)"
        }
    }
}
