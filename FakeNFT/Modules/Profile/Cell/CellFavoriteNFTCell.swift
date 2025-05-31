import SwiftUI

struct CellFavoriteNFTCell: View {
    
    let nft: NFT
    @EnvironmentObject private var profileEditViewModel: ProfileEditViewModel
    @State private var rating: Int = 0
    @State private var inFavorites: Bool = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                if let imageUrlString = nft.images.first,
                   let url = URL(string: imageUrlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 108, height: 108)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 108, height: 108)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .frame(width: 108, height: 108)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 108, height: 108)
                }
                
                Button(action: {
                    inFavorites.toggle()
                    Task {
                        await profileEditViewModel.favoriteAddRemove(nft: nft)
                    }
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

#Preview {
    CellFavoriteNFTCell(nft: MockNFT.shared.nfts[0])
        .environmentObject(ProfileEditViewModel())
}


