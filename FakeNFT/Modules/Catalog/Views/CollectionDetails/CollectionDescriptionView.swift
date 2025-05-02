//
//  CollectionDescriptionView.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CollectionDescriptionView: View {
    var collection: Collection
    var extractedName: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(extractedName)
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text("Автор коллекции:")
                NavigationLink(destination: AuthorDetailsView().withCustomBackButton()) {
                    Text(collection.author)
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)

            Text(collection.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .lineLimit(nil) // Убираем ограничение на количество строк
                .fixedSize(horizontal: false, vertical: true) // Разрешаем вертикальное растяжение
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}


