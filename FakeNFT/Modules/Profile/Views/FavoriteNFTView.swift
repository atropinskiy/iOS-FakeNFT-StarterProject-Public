import SwiftUI

struct FavoriteNFTView: View {
    
    @EnvironmentObject var viewModel: FavoriteNFTViewModel
    @Environment(\.dismiss) private var dismiss
    
    let columns = [
        GridItem(.flexible(), spacing: 7),
        GridItem(.flexible(), spacing: 7)
    ]
    
    var body: some View {
        
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Подгружаем NFT...")
                    }
                } else if viewModel.favoriteNfts.isEmpty {
                    Text("У вас еще нет избранных NFT")
                        .font(.system(size: 17, weight: .bold))
                } else {
                    ScrollView {
                        
                        LazyVGrid(columns: columns, spacing: 7) {
                            ForEach(viewModel.favoriteNfts, id: \.self) { nft in
                                CellFavoriteNFTCell(nft: nft)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 16)
                    .scrollContentBackground(.hidden)
                }
            }
            .onAppear {
                if viewModel.favoriteNfts.isEmpty {
                    viewModel.loadFavorites()                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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
                Text("Избранные NFT")
                    .font(.system(size: 17, weight: .bold))
            }
        }
    }
}

#Preview {
    FavoriteNFTView()
        .environmentObject(FavoriteNFTViewModel())
}
