import SwiftUI

struct CellFavoriteNFTCell: View {
    
    let nft: NFT
    
    @State private var rating: Int = 0
    @State private var inFavorites: Bool = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                Image(nft.images[0])
                    .resizable()
                    .background(.gray)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button(action: {
                    inFavorites.toggle()
                }, label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(inFavorites ? Color(.tRedUn) : Color(.white))
                })
                .padding(5)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(nft.name)
                    .font(.system(size: 17, weight: .bold))
                
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= nft.rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(index <= nft.rating ? Color(.tYellowUn) : .gray)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                
                Text((String(format: "%.2f ETH", nft.price)))
                    .font(.system(size: 15, weight: .regular))
            }
        }
    }
}

struct CellFavoriteNFTCellPreview: PreviewProvider {
    static var previews: some View {
        CellFavoriteNFTCell(nft: MockNFT.shared.nfts[0])
            .previewLayout(.sizeThatFits)
    }
}

