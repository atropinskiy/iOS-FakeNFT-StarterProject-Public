//
//  SwiftUIView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.crop.circle")
                        .foregroundColor(.black)
                }

            CatalogView()
                .tabItem {
                    Label("Каталог", systemImage: "square.stack.fill")
                        .foregroundColor(.black)
                }

            CartView()
                .tabItem {
                    Label("Корзина", systemImage: "3.circle")
                        .foregroundColor(.black)
                }

            StatView()
                .tabItem {
                    Label("Статистика", systemImage: "flag.2.crossed.fill")
                        .foregroundColor(.black)
                }
        }
    }
}

#Preview {
    TabBarView()
}
