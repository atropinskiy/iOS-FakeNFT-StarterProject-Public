import SwiftUI

struct MyNFTView: View {
    
    @EnvironmentObject var viewModel: MyNFTViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSortSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Подгружаем NFT...")
                            .font(.system(size: 16, weight: .medium))
                    }
                } else if viewModel.myNfts.isEmpty {
                    Text("У вас еще нет NFT")
                        .font(.system(size: 17, weight: .bold))
                } else {
                    List(viewModel.myNfts, id: \.self)  { nft in
                        
                        CellNFTView(nft: nft)
                            .listStyle(.plain)
                            .listRowSeparator(.hidden)
                            .padding(.trailing, 39)
                    }
                }
            }
            .onAppear {
                if viewModel.myNfts.isEmpty {
                    viewModel.loadData()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .listStyle(PlainListStyle())
        .buttonStyle(PlainButtonStyle())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(.tBlack))
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Мои NFT")
                    .font(.system(size: 17, weight: .bold))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSortSheet = true
                } label: {
                    Image(.vector)
                        .foregroundStyle(Color(.tBlack))
                }
            }
        }
        .confirmationDialog("Сортировка", isPresented: $showSortSheet, titleVisibility: .visible) {
            ButtonStack()
        }
    }
}

private struct ButtonStack: View {
    
    @EnvironmentObject var viewModel: MyNFTViewModel
    
    var body: some View {
        VStack {
            Button("По названию") {
                viewModel.sortNFTs(by: .name)
            }
            Button("По рейтингу") {
                viewModel.sortNFTs(by: .rating)
            }
            Button("По цене") {
                viewModel.sortNFTs(by: .price)
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}



#Preview {
    MyNFTView()
        .environmentObject(MyNFTViewModel())
}
