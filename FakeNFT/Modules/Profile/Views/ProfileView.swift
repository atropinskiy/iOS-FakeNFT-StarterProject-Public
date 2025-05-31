import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var profileEditViewModel: ProfileEditViewModel
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
                VStack(alignment: .leading) {
                    if profileEditViewModel.isLoading {
                        Spacer()
                        ProgressView("Загрузка...")
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.tBlack)))
                            .padding(.top, 50)
                        Spacer()
                    } else {
                        HStack() {
                            AsyncImage(url: URL(string: profileEditViewModel.profile.avatar)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                case .failure:
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            Text(profileEditViewModel.profile.name)
                                .font(.system(size: 22, weight: .bold))
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(profileEditViewModel.profile.description)
                                .font(.system(size: 13, weight: .regular))
                                .foregroundStyle(Color(.tBlack))
                                .lineLimit(nil)
                            Text(profileEditViewModel.profile.website)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(Color(.tBlueUn))
                        }
                        .padding(.top, 20)
                        ContentView()
                            .padding(.top, 40)
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .sheet(isPresented: $showEditProfileView) {
                    ProfileEditView()
                }
            }
        }
        .task {
            await profileEditViewModel.loadProfile()
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ProfileEditViewModel())
        .environmentObject(FavoriteNFTViewModel())
        .environmentObject(MyNFTViewModel())
}


