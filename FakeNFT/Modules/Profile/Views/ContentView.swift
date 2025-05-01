import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            
            MenuRow(title: "Мои NFT", count: 112, destination: MyNFTView())
            
            MenuRow(title: "Избранные NFT", count: 11, destination: FavoriteNFTView())
            
            MenuRow(title: "О разработчике", count: nil, destination: DeveloperInfoView())
        }
    }
}

struct MenuRow<Destination: View>: View {
    
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
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
            .frame(maxHeight: 54)
        }
        .buttonStyle(PlainButtonStyle()) // убирает эффект затемнения
    }
}

#Preview {
    ContentView()
}

