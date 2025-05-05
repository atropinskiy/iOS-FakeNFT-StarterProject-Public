import SwiftUI

enum SortOption {
    case price
    case rating
    case name
    case sort
}

struct SortSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var onSelect: (SortOption) -> Void

    var body: some View {
        
        VStack(spacing: 0) {

            VStack(spacing: 0) {
                
                Text("Сортировка")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                
                Divider()
                
                sortButton("По цене", option: .price)
                Divider()
                sortButton("По рейтингу", option: .rating)
                Divider()
                sortButton("По названию", option: .name)
            }
            .background(Color.white .opacity(0.3))
            .cornerRadius(16)

            Spacer().frame(height: 12)

            Button(action: {
                dismiss()
            }) {
                Text("Закрыть")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color(.tWhite))
                    .cornerRadius(16)
            }
        }
        .padding(.horizontal, 8)
        .background(Color(.clear))
    }

    private func sortButton(_ title: String, option: SortOption) -> some View {
        Button(action: {
            onSelect(option)
            dismiss()
        }) {
            Text(title)
                .font(.system(size: 17))
                .foregroundStyle(Color(.tBlueUn))
                .frame(maxWidth: .infinity, minHeight: 50)
        }
    }
}

#Preview {
    SortSheetView(onSelect: { _ in })
}

