//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogCell: View {
    @ObservedObject var viewModel: CatalogViewModel
    let collection: Collection
    var body: some View {
        VStack(spacing: 0) {
            KFImageView(
                urlString: collection.cover,
                height: 140,
                cornerRadius: 12
            )
            Text("\(viewModel.extractFileName(from: collection.cover) ?? "Без имени") (\(collection.nfts.count))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 13)
        }
        .frame(maxWidth: .infinity, maxHeight: 179)
    }
}
