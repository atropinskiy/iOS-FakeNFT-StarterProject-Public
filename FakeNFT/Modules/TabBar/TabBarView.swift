//
//  SwiftUIView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var profileViewModel = ProfileEditViewModel()
    @StateObject private var statViewModel = ProfileStatViewModel()
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
            StatView(viewModel: statViewModel)
                .tabItem {
                    VStack {
                        Image("StatTabBarImage")
                            .renderingMode(.template)
                        Text("Статистика")
                    }
                }
                .onAppear() {
                    Task { @MainActor in
                        await statViewModel.fetchFavoriteAndCart()
                    }
                }
        }
        .accentColor(Color(.tBlueUn))
        .environmentObject(profileViewModel)
    }
    
    
}

#Preview {
    TabBarView()
}
