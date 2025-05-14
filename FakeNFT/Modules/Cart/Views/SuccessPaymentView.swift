//
//  SuccessPaymentView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import SwiftUI

struct SuccessPaymentView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 20) {
                Image(.successPayment)
                    .resizable()
                    .frame(width: 278, height: 278)
                
                Text("Успех! Оплата прошла, поздравляем с покупкой!")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color(.tBlack))
                    .multilineTextAlignment(.center)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                dismiss()
            }) {
                Text("Вернуться в каталог")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color(.tWhite))
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(Color(.tBlack))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .navigationBarHidden(true)
    }
}

#Preview {
    SuccessPaymentView()
}

