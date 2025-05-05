import SwiftUI

struct DeveloperInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            Text("О разработчике")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(.tBlack))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("О разработчике")
    }
}

#Preview {
    DeveloperInfoView()
}
