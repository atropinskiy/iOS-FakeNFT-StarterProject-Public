import SwiftUI

struct MyNFTView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var nfts: [Nft] = []
    @State private var showSortSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            Text("У вас еще нет NFT")
            
        }
        .navigationBarBackButtonHidden(true)
        .listStyle(PlainListStyle())
        .buttonStyle(PlainButtonStyle())
        .navigationTitle("Мои NFT")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSortSheet = true
                } label: {
                    Image(.vector)
                }
            }
        }
        .confirmationDialog("Сортировка", isPresented: $showSortSheet, titleVisibility: .visible) {
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
