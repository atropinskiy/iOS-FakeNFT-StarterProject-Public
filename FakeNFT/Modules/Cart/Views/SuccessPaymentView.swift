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
            // TODO: Это окно-заглушка для реализации открытия окна по нажатию на кнопку оплатить. Само окно будет реализовано в модуле 3
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.tGreenUn))
            
            Text("Оплата прошла успешно!")
                .font(.title2)
                .bold()
            
            Text("ID платежа: \(payment.id)")
                .font(.subheadline)
                .foregroundStyle(Color(.tGrayUn))
            
            Spacer()
        }
        .padding()
        .navigationTitle("Успешно")
    }
}

#Preview {
    SuccessPaymentView(payment: .init(success: true, orderId: "1", id: "0"))
}

