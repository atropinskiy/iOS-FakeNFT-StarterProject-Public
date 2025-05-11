//
//  CatalogCollectionGrid.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogCollectionGridView: View {
    @ObservedObject var viewModel: CatalogViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            // Убираем дубликаты по id и сортируем по имени
            let uniqueNFTs = Array(Set(viewModel.currentCollectionNfts.map { $0.id }).compactMap { id in
                viewModel.currentCollectionNfts.first { $0.id == id }
            })
            // Сортируем по имени NFT
            let sortedNFTs = uniqueNFTs.sorted { $0.name < $1.name }

            ForEach(sortedNFTs, id: \.id) { nft in
                CatalogGridCell(viewModel: viewModel, nft: nft)
            }
        }
        .padding()
    }
}
