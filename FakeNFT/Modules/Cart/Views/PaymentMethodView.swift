//
//  Untitled.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct PaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Здесь будет реализован выбор валюты в модуле 2")
                .padding(.horizontal)
                .font(.body)
                .foregroundColor(.gray)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Выберите способ оплаты")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color("tBlack"))
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("tBlack"))
                }
            }
        }
    }
}

#Preview {
    PaymentMethodView()
}
