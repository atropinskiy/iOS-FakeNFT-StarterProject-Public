//
//  Untitled.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct PaymentMethodView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var paymentMethodViewModel = PaymentMethodViewModel()
    @State private var showUserAgreement: Bool = false
    @State private var navigationToSuccess = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if paymentMethodViewModel.isLoading {
                        Spacer()
                        ProgressView("Загрузка валют...")
                        Spacer()
                    } else if let error = paymentMethodViewModel.errorMessage {
                        VStack(spacing: 12) {
                            Text("Ошибка")
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(error)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Button("Повторить") {
                                paymentMethodViewModel.loadCurrency()
                            }
                            .padding(.top)
                        }
                        .padding()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns,alignment: .center ,spacing: 7) {
                                ForEach(paymentMethodViewModel.currencies) { currency in
                                    CurrencyCellView(
                                        currency: currency,
                                        isSelected: paymentMethodViewModel.selectedCurrencyId == currency.id)
                                    .onTapGesture {
                                        paymentMethodViewModel.selectCurrency(with: currency.id)
                                    }
                                    .frame(width: (UIScreen.main.bounds.width - 16 * 2 - 7) / 2)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 0 ) {
                            Text("Совершая покупку, вы соглашаетесь с условиями ")
                                .font(.system(size: 13))
                                .foregroundColor(Color("tBlack"))
                            Text("Пользовательского соглашения")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color(.tBlueUn))
                                .onTapGesture {
                                    showUserAgreement = true
                                }
                        }
                        
                        Button(action: {
                            paymentMethodViewModel.makePayment(currencyID: paymentMethodViewModel.selectedCurrencyId)
                        }) {
                            Text("Оплатить")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 60)
                            
                        }
                        .padding(.horizontal, 20)
                        .background(Color("tBlack"))
                        .cornerRadius(16)
                        .disabled(paymentMethodViewModel.selectedCurrencyId == nil || paymentMethodViewModel.isPaymentLoading)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    .background(Color("tLightGray"))
                    .cornerRadius(16)
                    .frame(minHeight: 186)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Выберите способ оплаты")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color("tBlack"))
                    }
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
                
                if paymentMethodViewModel.isPaymentLoading {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                    
                    ProgressView()
                        .frame(width: 81, height: 82)
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            
            .navigationDestination(isPresented: $navigationToSuccess) {
                if let payment = paymentMethodViewModel.paymentResult {
                    SuccessPaymentView(payment: payment)
                }
            }
            .onChange(of: paymentMethodViewModel.paymentResult) { result in
                if result != nil {
                    navigationToSuccess = true
                }
            }
            .sheet(isPresented: $showUserAgreement) {
                CartWebView(url: URL(string: "https://yandex.ru/legal/practicum_offer/")!)
            }
        }
    }
}

#Preview {
    PaymentMethodView()
}
