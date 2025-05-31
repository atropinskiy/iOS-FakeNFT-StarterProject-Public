import SwiftUI

struct FavoriteNFTView: View {
    
    @EnvironmentObject var viewModel: FavoriteNFTViewModel
    @EnvironmentObject private var profileEditViewModel: ProfileEditViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isFavNftLoading = true
    
    let columns = [
        GridItem(.flexible(), spacing: 7),
        GridItem(.flexible(), spacing: 7)
    ]
    
    var isLoading: Bool {
        profileEditViewModel.isLoading
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Group {
                    if profileEditViewModel.myFavNFTS.isEmpty && !isLoading {
                        Text("У вас еще нет избранных NFT")
                            .font(.system(size: 17, weight: .bold))
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 7) {
                                ForEach(profileEditViewModel.myFavNFTS, id: \.self) { nft in
                                    CellFavoriteNFTCell(nft: nft)
                                }
                            }
                            .padding(.top, 20)
                        }
                        .padding(.horizontal, 16)
                        .scrollContentBackground(.hidden)
                    }
                }
                .blur(radius: isLoading ? 3 : 0)
                
                if isLoading {
                    ZStack {
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Подгружаем NFT...")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding()
                    }
                }
            }
            .onReceive(profileEditViewModel.$myFavNFTS) { nfts in
                viewModel.updateNFTs(with: nfts)
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
        .environmentObject(ProfileEditViewModel())
        .environmentObject(FavoriteNFTViewModel())
}


