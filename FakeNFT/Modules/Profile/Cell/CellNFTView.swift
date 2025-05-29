import SwiftUI

struct CellNFTView: View {
    
    let nft: NFT
    
    @State private var rating: Int = 0
    @State private var inFavorites: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                Image(nft.images[0])
                    .resizable()
                    .background(.gray)
                    .frame(width: 108, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button {
                    inFavorites.toggle()
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 20, height: 18)
                        .foregroundStyle(inFavorites ? Color(.tRedUn) : Color.white)
                        .padding(11)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
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
                
                Text("от \(nft.author)")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(.tBlack))
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Цена")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(.tBlack))
                
                Text((String(format: "%.2f ETH", nft.price)))
                    .font(.system(size: 17, weight: .bold))
            }
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        CellNFTView(nft: MockNFT.shared.nfts[0])
            .previewLayout(.sizeThatFits)
    }
}

