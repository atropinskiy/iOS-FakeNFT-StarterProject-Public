import Foundation

@MainActor
final class MyNFTViewModel: ObservableObject {
    
    @Published var myNfts: [NFT] = []
    @Published var isLoading: Bool = false
    
    func updateNFTs(with nfts: [NFT]) {
        myNfts = nfts
        isLoading = false
    }
}


