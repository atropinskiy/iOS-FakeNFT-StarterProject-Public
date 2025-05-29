//
//  View.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    // Модифицатор, который делает навбар прозрачным
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = color  // Цвет фона
        appearance.shadowColor = .clear  // Убираем тень (если нужно)
        appearance.configureWithTransparentBackground()  // Делает фон прозрачным
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}
