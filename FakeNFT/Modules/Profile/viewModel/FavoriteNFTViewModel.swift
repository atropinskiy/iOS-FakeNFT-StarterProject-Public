import Foundation

@MainActor
final class FavoriteNFTViewModel: ObservableObject {
    
    @Published var favoriteNfts: [NFT] = []
    @Published var isLoading: Bool = false
        
    func updateNFTs(with nfts: [NFT]) {
        favoriteNfts = nfts
    }
}

