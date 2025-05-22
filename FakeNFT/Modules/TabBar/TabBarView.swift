//
//  SwiftUIView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var catalogViewModel = CatalogViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    
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
            
            CatalogView(viewModel: catalogViewModel)
                .tabItem {
                    VStack {
                        Image("CatalogTabBarImage")
                            .renderingMode(.template)
                        Text("Каталог")
                    }
                }
            
            CartView(cartViewModel: cartViewModel)
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
        .onAppear {
            catalogViewModel.fetchCollections()
            catalogViewModel.fetchLikesAndCart()
        }
    }
    
    
}

#Preview {
    TabBarView()
}
