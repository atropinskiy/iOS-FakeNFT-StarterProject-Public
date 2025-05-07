import SwiftUI

struct FavoriteNFTView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var favoriteNfts: [Nft] = []
    
    var body: some View {
        
        NavigationView {
            Text("У вас еще нет избранных NFT")
                .font(.system(size: 17, weight: .bold))
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
}
