import Foundation

final class FavoriteNFTViewModel: ObservableObject {
    
    @Published var favoriteNfts: [NFT] = []
    @Published var isLoading: Bool = false
    
    init() {
        favoriteNfts = MockNFT.shared.nfts
    }
    
    func loadFavorites() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.favoriteNfts = MockNFT.shared.nfts 
            self.isLoading = false
        }
    }
}
