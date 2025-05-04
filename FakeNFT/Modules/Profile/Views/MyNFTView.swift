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
        .sheet(isPresented: $showSortSheet) {
            ZStack {
                // Затемнение фона
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                // Сам шит
                VStack {
                    Spacer()
                    SortSheetView { option in
                        // Обработка выбора
                        print("Выбрана сортировка: \(option)")
                    }
                }
            }
            .background(ClearBackgroundView()) // Убирает белый фон sheet
            .presentationDetents([.height(320)]) // или .fraction(0.35) — регулируй по вкусу
            .presentationDragIndicator(.visible)
        }
    }
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}




#Preview {
    MyNFTView()
}
