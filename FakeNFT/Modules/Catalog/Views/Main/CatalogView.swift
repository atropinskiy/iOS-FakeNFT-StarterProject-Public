//
//  CatalogView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject var viewModel = CatalogViewModel()
    @State private var showActionSheet = false
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: {
                        showActionSheet.toggle()
                    }, label: {
                        Image("CatalogMenuBtn") // Иконка меню
                    })
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text(""), message: Text("Сортировка"), buttons: [
                            .default(Text("По названию")) {
                                viewModel.orderType = .name
                            },
                            .default(Text("По количеству NFT")) {
                                viewModel.orderType = .count
                            },
                            .cancel()
                        ])
                    }
                }
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.collectionsList, id: \.id) { collection in
                                NavigationLink(
                                    destination: CollectionDetailsView(viewModel: viewModel, collection: collection)) {
                                    CatalogCell(viewModel: viewModel, collection: collection)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    .scrollIndicators(.never)
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    CatalogView()
}
