import SwiftUI

struct ProfileView: View {

    @State private var showEditProfileView: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                
                Spacer()
                
                Button {
                    
                    showEditProfileView = true
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .foregroundStyle(Color(.tBlack))
                        .frame(width: 26.34, height: 26.33)
                }
                .frame(width: 42, height: 42)
                .padding(.horizontal, 9)
            }
            
            VStack(alignment: .leading) {
                
                HStack() {
                    Image(.joaquin)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    Text("Joaquin Pheonix")
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("""
                    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции есть уже 100+
                    моделей из 100+ NFT, и еще больше на моем сайте. Открыт к коллаборациям.
                    """)
                    .font(.system(size: 13, weight: .light))
                    .foregroundStyle(Color(.tBlack))
                    .lineLimit(nil)
                    
                    Text("Joaquin@Pheonix.com")
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(Color(.tBlueUn))
                }
                .padding(.top, 20)
                
                ContentView()
                    .padding(.top, 40)
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showEditProfileView ) {
                ProfileEditView()
            }
        }
    }
}

#Preview {
    ProfileView()
}
