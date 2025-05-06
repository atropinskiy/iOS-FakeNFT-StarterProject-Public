import SwiftUI

struct DeveloperInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            Text("О разработчике")
                .font(.system(size: 17, weight: .bold))
        }
        .navigationBarBackButtonHidden(true)
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
                Text("О разработчике")
                    .font(.system(size: 17, weight: .bold))
            }
        }
    }
}

#Preview {
    DeveloperInfoView()
}
