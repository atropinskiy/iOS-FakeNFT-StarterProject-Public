import SwiftUI

struct MyNFTView: View {
    
    @EnvironmentObject var viewModel: ProfileEditViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSortSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                        Text("Подгружаем NFT...")
                            .font(.system(size: 16, weight: .medium))
                    }
                } else if viewModel.MyNfts.isEmpty {
                    Text("У вас еще нет NFT")
                        .font(.system(size: 17, weight: .bold))
                } else {
                    List(viewModel.MyNfts, id: \.self)  { nft in
                        
                        CellNFTView(nft: nft)
                            .listStyle(.plain)
                            .listRowSeparator(.hidden)
                            .padding(.trailing, 39)
                    }
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
            ButtonStack()
        }
    }
}

private struct ButtonStack: View {
    
    @EnvironmentObject var viewModel: ProfileEditViewModel
    
    var body: some View {
        VStack {
            Button {
                sortedByName()
                print("Option 1 - Сортировка по названию")
            } label: {
                Text("По названию")
                    .foregroundStyle(Color(.tBlueUn))
            }
            Button {
                sortedByRating()
                print("Option 2 - Сортировка по рейтингу")
            } label: {
                Text("По рейтингу")
                    .foregroundStyle(Color(.tBlueUn))
            }
            Button {
                sortedByPrice()
                print("Option 3 - Сортировка по цене")
            } label: {
                Text("По цене")
                    .foregroundStyle(Color(.tBlueUn))
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
    
    func sortedByName() {
        viewModel.MyNfts.sort { $0.name < $1.name }
    }
    
    func sortedByRating() {
        viewModel.MyNfts.sort { $0.rating < $1.rating }
    }
    
    func sortedByPrice() {
        viewModel.MyNfts.sort { $0.price < $1.price }
    }
}



#Preview {
    MyNFTView()
        .environmentObject(ProfileEditViewModel())
}
