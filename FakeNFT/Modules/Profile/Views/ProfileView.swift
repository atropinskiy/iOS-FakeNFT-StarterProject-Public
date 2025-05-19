import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: ProfileEditViewModel
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
                    Text(viewModel.nameProfile)
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.descriptionProfile)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color(.tBlack))
                        .lineLimit(nil)
                    
                    Text(viewModel.websiteProfile)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(Color(.tBlueUn))
                }
                .padding(.top, 20)
                
                ContentView()
                    .padding(.top, 40)
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showEditProfileView) {
                ProfileEditView()
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ProfileEditViewModel())
        .environmentObject(FavoriteNFTViewModel())
        .environmentObject(MyNFTViewModel())
}
