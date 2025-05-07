import SwiftUI

struct MyNFTView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var MyNfts: [Nft] = []
    @State private var showSortSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            Text("У вас еще нет NFT")
                .font(.system(size: 17, weight: .bold))
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
    var body: some View {
        VStack {
            Button {
                print("Option 1 - Сортировка по имени")
            } label: {
                Text("По имени")
                    .foregroundStyle(Color(.tBlueUn))
            }
            Button {
                print("Option 2 - Сортировка по рейтингу")
            } label: {
                Text("По рейтингу")
                    .foregroundStyle(Color(.tBlueUn))
            }
            Button {
                print("Option 2 - Сортировка по названию")
            } label: {
                Text("По названию")
                    .foregroundStyle(Color(.tBlueUn))
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}

#Preview {
    MyNFTView()
}
