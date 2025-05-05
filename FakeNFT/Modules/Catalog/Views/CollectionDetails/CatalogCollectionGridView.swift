//
//  CatalogCollectionGrid.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogCollectionGridView: View {
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
            ForEach(Array(images.enumerated()), id: \.offset) { _, image in
                CatalogGridCell(imgName: image)
            }
        }
        .padding()
    }
}
