//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogCell: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("MockCollectionImg")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
            Text("Коллекция 1")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 13)
        }
        .frame(maxWidth: .infinity, maxHeight: 179)
    }
}

#Preview {
    CatalogCell()
}
