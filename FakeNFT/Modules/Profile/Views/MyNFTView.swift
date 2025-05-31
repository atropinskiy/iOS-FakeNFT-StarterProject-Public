import SwiftUI

struct MyNFTView: View {
    
    @StateObject private var viewModel = MyNFTViewModel()

    @EnvironmentObject private var profileEditViewModel: ProfileEditViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSortSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Group {
                    if profileEditViewModel.myLoadedNFTs.isEmpty && !profileEditViewModel.isLoading {
                        Text("У вас еще нет NFT")
                            .font(.system(size: 17, weight: .bold))
                    } else {
                        List(profileEditViewModel.myLoadedNFTs, id: \.self)  { nft in
                            CellNFTView(nft: nft)
                                .listStyle(.plain)
                                .listRowSeparator(.hidden)
                                .padding(.trailing, 39)
                        }
                    }
                }
                .blur(radius: profileEditViewModel.isLoading ? 3 : 0)

                if profileEditViewModel.isLoading {
                    ZStack {
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Подгружаем NFT...")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding()
                    }
                }
            }
            .onReceive(profileEditViewModel.$myLoadedNFTs) { nfts in
                viewModel.updateNFTs(with: nfts)
            }
        }
        .navigationBarBackButtonHidden(true)
        .listStyle(PlainListStyle())
        .buttonStyle(PlainButtonStyle())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(.tBlack))
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Мои NFT")
                    .font(.system(size: 17, weight: .bold))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSortSheet = true
                } label: {
                    Image(.vector)
                        .foregroundStyle(Color(.tBlack))
                }
            }
        }
        .confirmationDialog("Сортировка", isPresented: $showSortSheet, titleVisibility: .visible) {
            ButtonStack(viewModel: viewModel )
        }
    }
}

private struct ButtonStack: View {
    
    @ObservedObject var viewModel: MyNFTViewModel
    @EnvironmentObject private var profileEditViewModel: ProfileEditViewModel

    var body: some View {
        VStack {
            Button("По названию") {
                profileEditViewModel.sortNFTs(by: .name)
            }
            Button("По рейтингу") {
                profileEditViewModel.sortNFTs(by: .rating)
            }
            Button("По цене") {
                profileEditViewModel.sortNFTs(by: .price)
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}

#Preview {
    MyNFTView()
        .environmentObject(ProfileEditViewModel())
}


