//
//  PaymentMethodViewModel.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import Foundation

@MainActor
final class PaymentMethodViewModel: ObservableObject {
    @Published var currencies: [Currency] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var selectedCurrencyId: String?
    
    @Published var paymentResult: Payment?
    @Published var isPaymentLoading = false
    @Published var paymentError: String?
    
    @Published var cartEditionError: String?
    
    private let orderId: String = "1"
    private let networkService = NetworkServiceFunction.shared

    init() {
        loadCurrency()
    }
    
    func loadCurrency() {
        Task {
            await fetchAllCurrencies()
        }
    }
    
    func refresh() async {
        await fetchAllCurrencies()
    }
    
    func getEmptyCart() {
        Task {
            await emptyCart()
        }
    }
    
    /// Select currency for payment
    func selectCurrency(with id: String) {
        selectedCurrencyId = id
    }
    
    func makePayment(currencyID: String?) async {
        guard let selectedIdStr = currencyID,
              let selectedId = Int(selectedIdStr) else {
            paymentError = "Некорректный ID валюты"
            return
        }
        
        await performPayment(with: selectedId)
    }
    
    /// Fetch all available currency
    private func fetchAllCurrencies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let loadedCurrencies = try await networkService.fetchCurrencies()
            self.currencies = loadedCurrencies
        } catch {
            self.errorMessage = "Не удалось загрузить валюты: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Creates a payment request
    private func performPayment(with id: Int) async {
        isPaymentLoading = true
        paymentError = nil
        do {
            let payment = try await networkService.fetchPayment(by: id)
            self.paymentResult = payment
            
            if payment.success {
                await emptyCart()
            }
        } catch {
            self.paymentError = "Ошибка оплаты: \(error.localizedDescription)"
        }
        isPaymentLoading = false
    }
    
    /// Clear cart after success payment
    private func emptyCart() async {
        do {
            _ = try await networkService.uploadNFTSToCart(by: orderId, nfts: [])
        } catch {
            self.cartEditionError = "Error emptying cart: \(error.localizedDescription)"
        }
    }
}

