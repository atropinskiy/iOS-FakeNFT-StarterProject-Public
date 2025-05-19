//
//  Untitled.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct PaymentMethodView: View {
    let cartViewModel: CartViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var paymentMethodViewModel = PaymentMethodViewModel()
    @State private var showUserAgreement: Bool = false
    @State private var navigationToSuccess = false
    @State private var showPaymentErrorAlert = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var isReadyToPay: Bool {
        paymentMethodViewModel.selectedCurrencyId == nil || paymentMethodViewModel.isPaymentLoading
    }
    
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
                                .foregroundStyle(Color(.tRedUn))
                            Text(error)
                                .font(.subheadline)
                                .foregroundStyle(Color(.tGrayUn))
                            Button("Повторить") {
                                paymentMethodViewModel.loadCurrency()
                            }
                            .padding(.top)
                        }
                        .padding()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns ,spacing: 7) {
                                ForEach(paymentMethodViewModel.currencies) { currency in
                                    CurrencyCellView(
                                        currency: currency,
                                        isSelected: paymentMethodViewModel.selectedCurrencyId == currency.id)
                                    .onTapGesture {
                                        withAnimation {
                                            paymentMethodViewModel.selectCurrency(with: currency.id)
                                        }
                                    }
                                    .frame(width: (UIScreen.main.bounds.width - 16 * 2 - 7) / 2)
                                    .transition(.opacity.combined(with: .scale))
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                        }
                        .refreshable {
                            let start = Date()
                            try? await Task.sleep(nanoseconds: 700_000_000)
                            await paymentMethodViewModel.refresh()
                            
                            let elapsed = Date().timeIntervalSince(start)
                            if elapsed < 0.7 {
                                try? await Task.sleep(nanoseconds: UInt64((0.7 - elapsed) * 1_000_000_000))
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 0 ) {
                            Text("Совершая покупку, вы соглашаетесь с условиями")
                                .font(.system(size: 13,  weight: .regular))
                                .foregroundStyle(Color(.tBlack))
                            Text("Пользовательского соглашения")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundStyle(Color(.tBlueUn))
                                .onTapGesture {
                                    showUserAgreement = true
                                }
                        }
                        
                        Button(action: {
                            Task {
                                await paymentMethodViewModel.makePayment(currencyID: paymentMethodViewModel.selectedCurrencyId)
                            }
                        }) {
                            Text("Оплатить")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color(.tWhite))
                                .frame(maxWidth: .infinity, minHeight: 60)
                            
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 12)
                        .background(Color(isReadyToPay ? .tBackgroundUn : .tBlack))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .disabled(isReadyToPay)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 16)
                    .background(Color(.tLightGray))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(minHeight: 186)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Выберите способ оплаты")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color(.tBlack))
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color(.tBlack))
                        }
                    }
                }
                
                if paymentMethodViewModel.isPaymentLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .frame(width: 81, height: 82)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                        )
                }
            }
            .navigationDestination(isPresented: $navigationToSuccess) {
                SuccessPaymentView(cartViewModel: cartViewModel)
            }
            .onChange(of: paymentMethodViewModel.paymentResult) { result in
                if let result = result, result.success {
                    withAnimation {
                        navigationToSuccess = true
                    }
                } else {
                    showPaymentErrorAlert = true
                }
            }
            .sheet(isPresented: $showUserAgreement) {
                if let url = URL(string: "https://yandex.ru/legal/practicum_offer/") {
                    CartWebView(url: url)
                } else {
                    Text("Ошибка загрузки ссылки")
                }
            }
            .alert("Не удалось произвести оплату", isPresented: $showPaymentErrorAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Повторить") {
                    if let selectedID = paymentMethodViewModel.selectedCurrencyId {
                        Task {
                            await paymentMethodViewModel.makePayment(currencyID: selectedID)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PaymentMethodView(cartViewModel: CartViewModel())
}

