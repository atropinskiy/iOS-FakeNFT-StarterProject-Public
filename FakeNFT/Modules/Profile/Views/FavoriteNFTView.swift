import SwiftUI

struct FavoriteNFTView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var favoriteNsts: [Nft] = []
    
    var body: some View {
        
        NavigationView {
            
            Text("У вас еще нет избранных NFT")
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Избранные NFT")
    }
}

#Preview {
    FavoriteNFTView()
}
