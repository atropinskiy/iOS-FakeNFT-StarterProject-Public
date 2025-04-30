//
//  View.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

extension View {
    // Экстеншен, который меняет кнопку назад на <
    func withCustomBackButton() -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonView()
                }
            }
    }
}

private struct BackButtonView: View {
    // Костомное вью с < вместо back
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.backward")
            }
            .foregroundColor(.primary)
        }
    }
}

extension View {
    // Экстеншн для установки прозрачного фона навигационной панели
    func navigationBarColor(_ color: UIColor) -> some View {
        self.modifier(NavigationBarModifier(color: color))
    }
}
