//
//  CatalogDetails.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CollectionDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("MockCollectionImg")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .mask(RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .padding(.top, 0))

                VStack(spacing: 0) {
                    CollectionDescriptionView()
                    CatalogCollectionGridView()
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
