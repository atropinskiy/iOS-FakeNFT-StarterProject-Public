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
                    VStack {
                        Image("ProfileTabBarImage")
                            .renderingMode(.template)
                        Text("Профиль")
                    }
                }

            CatalogView()
                .tabItem {
                    VStack {
                        Image("CatalogTabBarImage")
                            .renderingMode(.template)
                        Text("Каталог")
                    }
                }

            CartView()
                .tabItem {
                    VStack {
                        Image("CartTabBarImage")
                            .renderingMode(.template)
                        Text("Корзина")
                    }
                }

            StatView()
                .tabItem {
                    VStack {
                        Image("StatTabBarImage")
                            .renderingMode(.template)
                        Text("Статистика")
                    }
                }
        }
        .accentColor(Color(.tBlueUn))
    }
}

#Preview {
    TabBarView()
}
