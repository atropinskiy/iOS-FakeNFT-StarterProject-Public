//
//  CollectionDescriptionView.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CollectionDescriptionView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Peach")
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("Автор коллекции")
                NavigationLink(destination: AuthorDetailsView().withCustomBackButton()) { // Переход на новый экран
                    Text("John Doe")  // Ссылка, которая будет вести на новый экран
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            Text("Персиковый — как облака над закатным солнцемв океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

