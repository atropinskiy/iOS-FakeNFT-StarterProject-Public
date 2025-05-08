//
//  SuccessPaymentView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import SwiftUI

struct SuccessPaymentView: View {
    let payment: Payment
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
            
            Text("Оплата прошла успешно!")
                .font(.title2)
                .bold()
            
            Text("ID платежа: \(payment.id)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Успешно")
    }
}

#Preview {
    SuccessPaymentView(payment: .init(success: true, orderId: "1", id: "0"))
}

