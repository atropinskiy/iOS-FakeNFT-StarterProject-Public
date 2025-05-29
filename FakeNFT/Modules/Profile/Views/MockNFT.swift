import SwiftUI

final class MockNFT {
    
    static let shared = MockNFT()
    
    let nfts: [NFT] = [
        
        NFT(createdAt: "", name: "Panda", images: ["panda"], rating: 3, description: "", price: 3.56, author: "Kostya", id: ""),
        NFT(createdAt: "", name: "Nechto", images: ["nechto"], rating: 2, description: "", price: 2.54, author: "Valera", id: ""),
        NFT(createdAt: "", name: "Miha", images: ["miha"], rating: 4, description: "", price: 5.16, author: "Oleg", id: ""),
        NFT(createdAt: "", name: "Hruha", images: ["hruha"], rating: 5, description: "", price: 4.33, author: "Alex", id: ""),
        NFT(createdAt: "", name: "Ediroga", images: ["ediroga"], rating: 1, description: "", price: 8.88, author: "Hikita", id: "")
     
    ]
    
}
