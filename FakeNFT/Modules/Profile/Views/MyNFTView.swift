import SwiftUI

struct MyNFTView: View {
    
    @StateObject private var viewModel = MyNFTViewModel()
    @StateObject private var profileViewModel = ProfileEditViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSortSheet: Bool = false
    @State private var isProfileLoading: Bool = true
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Group {
                    if viewModel.myNfts.isEmpty && !viewModel.isLoading && !isProfileLoading {
                        Text("У вас еще нет NFT")
                            .font(.system(size: 17, weight: .bold))
                    } else {
                        List(viewModel.myNfts, id: \.self)  { nft in
                            CellNFTView(nft: nft)
                                .listStyle(.plain)
                                .listRowSeparator(.hidden)
                                .padding(.trailing, 39)
                        }
                    }
                }
                .blur(radius: isProfileLoading || viewModel.isLoading ? 3 : 0)
                
                if isProfileLoading || viewModel.isLoading {
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
            .onReceive(profileViewModel.$myloadedNFTs) { nfts in
                viewModel.updateNFTs(with: nfts)
            }
            .onAppear {
                Task {
                    isProfileLoading = true
                    await profileViewModel.loadProfile()
                    isProfileLoading = false
                }
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
    
    var body: some View {
        VStack {
            Button("По названию") {
                viewModel.sortNFTs(by: .name)
            }
            Button("По рейтингу") {
                viewModel.sortNFTs(by: .rating)
            }
            Button("По цене") {
                viewModel.sortNFTs(by: .price)
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}

#Preview {
    MyNFTView()
        .environmentObject(MyNFTViewModel())
}

