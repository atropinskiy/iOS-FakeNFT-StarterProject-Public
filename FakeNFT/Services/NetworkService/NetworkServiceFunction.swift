//
//  NetworkServiceFunction.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 28.04.2025.
//

import SwiftUI

enum Endpoint: String {
    case collectionIdGet = "collections/"
    case collectionsGet = "collections"
    case nftGet = "nft"
    case nftIdGet = "nft/"
    case currencyIdGet = "currencies/"
    case currencyGet = "currencies"
    case orderGetPut = "orders/"
    case paymentCurrencyIdGet = "orders/1/payment/"
    case profileGetPut = "profile/"
    case usersGet = "users"
    case userIdGet = "users/"
}

final class NetworkServiceFunction {
    @MainActor static let shared = NetworkServiceFunction()
    private let networkService = NetworkService()
    
    private init() {}
    
    /// Fetch currency by id number
    func fetchCurrency(by id: Int) async throws -> Currency {
        try await networkService.fetchRequest(endpoint: .currencyIdGet, method: .get, idNumber: id)
    }
    
    /// Fetch all currencies array
    func fetchCurrencies() async throws -> [Currency] {
        try await networkService.fetchRequest(endpoint: .currencyGet, method: .get)
    }
    
    /// Fetch first order
    func fetchOrder(by id: Int) async throws -> Order {
        try await networkService.fetchRequest(endpoint: .orderGetPut, method: .get, idNumber: id)
    }
    
   }

