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
                    .resizable() // просто делаем изображение изменяемым
                    .frame(width: UIScreen.main.bounds.width, height: 310)
                    .clipped() // чтобы не вылезало за границы

                VStack(spacing: 0) {
                    CollectionDescriptionView()
                    CatalogCollectionGridView()
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)  // Заголовок будет фиксирован
        .navigationBarColor(UIColor.clear)
        .withCustomBackButton()
    }
}
