//
//  CatalogDetails.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CollectionDetailsView: View {
    @ObservedObject var viewModel: CatalogViewModel
    var collection: Collection
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                KFImageView(
                    urlString: collection.cover,
                    placeholder: {ProgressView()}
                )
                .mask(RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .padding(.top, 0))

                VStack(spacing: 0) {
                    CollectionDescriptionView(
                        collection: collection,
                        extractedName: viewModel.extractFileName(from: collection.cover) ?? "No title"
                    )
                    CatalogCollectionGridView(nfts: collection.nfts)
                }
                .frame(minHeight: 0, maxHeight: .infinity)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)  // Заголовок будет фиксирован
        .navigationBarColor(UIColor.clear)
        .withCustomBackButton()
    }
}
