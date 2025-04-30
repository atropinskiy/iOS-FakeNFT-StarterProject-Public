//
//  CatalogView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()
    @State private var showActionSheet = false
    
    var body: some View {
        
        NavigationStack(path: $viewModel.path) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: {
                        showActionSheet.toggle()
                    }) {
                        Image("CatalogMenuBtn") // Иконка меню
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text(""), message: Text("Сортировка"), buttons: [
                            .default(Text("По названию")) { print("Option 1 selected") },
                            .default(Text("По количеству NFT")) { print("Option 2 selected") },
                            .cancel()
                        ])
                    }
                }
                
                ScrollView {
                    NavigationLink(destination: CollectionDetailsView()) {
                        CatalogCell()
                    }
                    NavigationLink(destination: CollectionDetailsView()) {
                        CatalogCell()
                    }
                    NavigationLink(destination: CollectionDetailsView()) {
                        CatalogCell()
                    }
                }
                .padding(.top, 20)
            }
            .padding(16)
        }
    }
}

#Preview {
    CatalogView()
}
