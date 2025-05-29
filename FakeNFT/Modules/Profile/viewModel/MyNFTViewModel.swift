import Foundation

enum SortOption {
    case name
    case rating
    case price
}

@MainActor
final class MyNFTViewModel: ObservableObject {
    
    @Published var myNfts: [NFT] = []
    @Published var isLoading: Bool = false
    
    func sortNFTs(by option: SortOption) {
        switch option {
        case .name:
            myNfts.sort { $0.name < $1.name }
        case .rating:
            myNfts.sort { $0.rating > $1.rating } // рейтинг по убыванию?
        case .price:
            myNfts.sort { $0.price < $1.price }
        }
    }
    
    func loadData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // имитация запроса
            self.myNfts = MockNFT.shared.nfts
            self.isLoading = false
        }
    }
}
