//
//  CartView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct CartView: View {
    @State private var order: Order? = nil
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 16) {
            Button("Загрузить заказ") {
                Task {
                    await loadOrder()
                }
            }
            
            if let errorMessage = errorMessage {
                Text("Ошибка: \(errorMessage)")
                    .foregroundColor(.red)
            }
            
            if let order = order {
                Text("Заказ ID: \(order.id)")
                    .font(.headline)
                
                if order.nfts.isEmpty {
                    Text("NFT в заказе нет")
                        .foregroundColor(.gray)
                } else {
                    ForEach(order.nfts, id: \.self) { nftId in
                        Text("NFT ID: \(nftId)")
                    }
                }
            } else {
                Text("Данные не загружены")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    func loadOrder() async {
        do {
            let result = try await NetworkServiceFunction.shared.fetchOrder(by: 1)
            order = result
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    CartView()
}
