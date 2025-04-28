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
    
    private var networkService: NetworkService
    
    private init() {
        self.networkService = NetworkService()
    }
    
    
    func currencyIdGet(currencyId: String) async throws -> CurrencyIdResponse? {
        try await networkService.fetchRequest(endpoint: .currencyIdGet, method: .get, idNumber: <#T##String?#>, encodableData: <#T##(any Encodable)?#>)
        )
    }
    
   }

