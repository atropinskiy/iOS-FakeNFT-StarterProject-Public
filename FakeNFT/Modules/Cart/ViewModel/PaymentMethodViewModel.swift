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
    
    func selectCurrency(with id: String) {
        selectedCurrencyId = id
    }
    
    func makePayment(currencyID: String?) {
        guard let selectedIdStr = currencyID,
              let selectedId = Int(selectedIdStr) else {
            paymentError = "Некорректный ID валюты"
            return
        }
        
        Task {
            await performPayment(with: selectedId)
        }
    }
    
    func getEmptyCart() {
        Task {
            await emptyCart()
        }
    }
    
    private func performPayment(with id: Int) async {
        isPaymentLoading = true
        paymentError = nil
        do {
            let payment = try await NetworkServiceFunction.shared.fetchPayment(by: id)
            self.paymentResult = payment
        } catch {
            self.paymentError = "Ошибка оплаты: \(error.localizedDescription)"
        }
        isPaymentLoading = false
    }
    
    private func emptyCart() async {
        let orderId = "1"
        let emptyNFTSArray: [String] = []
        do {
            let order = try await networkService.uploadNFTSToCart(by: orderId, nfts: emptyNFTSArray)
        } catch {
            self.cartEditionError = "Error emptying cart: \(error.localizedDescription)"
        }
    }
}

