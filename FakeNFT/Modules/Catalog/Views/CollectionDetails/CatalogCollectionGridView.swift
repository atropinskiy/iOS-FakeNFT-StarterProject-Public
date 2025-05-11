//
//  CatalogCollectionGrid.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogCollectionGridView: View {
    private let nfts: [String]
    init (nfts: [String]) {
        self.nfts = nfts
        print(nfts)
    }
    let images = [
        "MockNFTImg", "MockNFTImg", "MockNFTImg",
        "MockNFTImg", "MockNFTImg", "MockNFTImg",
        "MockNFTImg", "MockNFTImg", "MockNFTImg",
        "MockNFTImg"]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(nfts, id: \.self) { nft in
                CatalogGridCell(nft: nft)
            }
        }
        .padding()
    }
}
