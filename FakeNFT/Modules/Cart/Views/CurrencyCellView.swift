//
//  CurrencyCellView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import SwiftUI

struct CurrencyCellView: View {
    private let imageSize: CGFloat = 36
    let currency: Currency
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            AsyncImage(url: URL(string: currency.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: imageSize, height: imageSize)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageSize, height: imageSize)
                        .background(Color(.tBlack))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .clipped()
                case .failure:
                    Color(.tGrayUn)
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text("\(currency.title)")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color(.tBlack))
                
                Text("\(currency.name)")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color(.tGreenUn))
            }
            Spacer()
        }
        .padding(.leading, 12)
        .frame(height: 46)
        .background(Color(.tLightGray))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color(.tBlack) : Color.clear, lineWidth: 1)
        )
    }
}

#Preview("With Frame") {
    let currency_1: Currency = .init(title: "Shiba_Inu", name: "SHIB", image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png", id: "0")
    
    CurrencyCellView(currency: currency_1, isSelected: true)
}

#Preview("Without Frame") {
    let currency_1: Currency = .init(title: "Shiba_Inu_2", name: "SHIB_2", image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png", id: "1")
    
    CurrencyCellView(currency: currency_1, isSelected: false)
}
