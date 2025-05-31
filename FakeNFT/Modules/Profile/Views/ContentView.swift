
import SwiftUI

struct ContentView: View {
    
    @StateObject private var myNFTViewModel = MyNFTViewModel()
    @StateObject private var favoriteNFTViewModel = FavoriteNFTViewModel()
    @EnvironmentObject private var profileEditViewModel: ProfileEditViewModel

    var body: some View {
        VStack(spacing: 0) {

            MenuRow(title: "Мои NFT",
                    count: profileEditViewModel.myLoadedNFTs.count,
                    destination: MyNFTView().environmentObject(myNFTViewModel))
            
            MenuRow(title: "Избранные NFT",
                    count: profileEditViewModel.myFavNFTS.count,
                    destination: FavoriteNFTView().environmentObject(favoriteNFTViewModel))
            
            MenuRow(title: "О разработчике",
                    count: nil,
                    destination: DeveloperInfoView())
        }
    }
}

struct StatMenuRow<Destination: View>: View {
    
    let title: String
    let count: Int?
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                if let count = count {
                    Text(title)
                        .fontWeight(.semibold)
                    Text("(\(count))")
                        .foregroundStyle(Color(.tBlack))
                        .fontWeight(.semibold)
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(.tBlack))
            }
            .frame(maxHeight: 54)
        }
        .buttonStyle(PlainButtonStyle()) // убирает эффект затемнения
    }
}

#Preview {
    ContentView()
        .environmentObject(ProfileEditViewModel())
}

