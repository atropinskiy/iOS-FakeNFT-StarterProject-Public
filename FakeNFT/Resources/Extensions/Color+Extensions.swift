//
//  Color.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//
import SwiftUI

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        
        var hexValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&hexValue)
        
        self.init(
            .sRGB,
            red: Double((hexValue & 0xFF0000) >> 16) / 255.0,
            green: Double((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(hexValue & 0x0000FF) / 255.0,
            opacity: 1.0 // Прозрачность 100%
        )
    }
}
