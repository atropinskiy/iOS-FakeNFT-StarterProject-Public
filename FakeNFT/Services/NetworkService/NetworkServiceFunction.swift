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
    
    /// Fetch all collection list
    func fetchCollections() async throws -> [Collection] {
        try await networkService.fetchRequest(endpoint: .collectionsGet, method: .get)
    }
    
    /// Fetch collection by id number
    func fetchCollection(by id: String) async throws -> Collection {
        try await networkService.fetchRequest(endpoint: .collectionIdGet, method: .get, id: id)
    }
    
    /// Fetch all nfts
    func fetchNfts() async throws -> [NFT] {
        try await networkService.fetchRequest(endpoint: .nftGet, method: .get)
    }
    
    /// Fetch nft with id
    func fetchNft(with id: String) async throws -> NFT {
        try await networkService.fetchRequest(endpoint: .nftIdGet, method: .get, id: id)
    }
    
    /// Fetch all currencies array
    func fetchCurrencies() async throws -> [Currency] {
        try await networkService.fetchRequest(endpoint: .currencyGet, method: .get)
    }
    
    /// Fetch currency by id number
    func fetchCurrency(by id: Int) async throws -> Currency {
        let currencyID: String = String(id)
        
        let selectedCurrency: Currency = try await networkService.fetchRequest(endpoint: .currencyIdGet, method: .get, id: currencyID)
        return selectedCurrency
    }
    
    /// Fetch first order
    func fetchOrder(by id: String) async throws -> Order {
        try await networkService.fetchRequest(endpoint: .orderGetPut, method: .get, id: id)
    }
    
    /// Fetch payment success
    func fetchPayment(by id: Int) async throws -> Payment {
        let curencyID: String = String(id)
        
        let currencyPayment: Payment = try await networkService.fetchRequest(endpoint: .paymentCurrencyIdGet, method: .get, id: curencyID)
        return currencyPayment
    }
    
    /// Add/delete new nft in Cart
    func uploadNFTSToCart(by id: String, nfts: [String]) async throws -> Order {
        let uploadedNFTS = NFTToCart(nfts: nfts)
        
        let updatedOrder: Order = try await networkService.fetchRequest(endpoint: .orderGetPut, method: .put, id: id, encodableData: uploadedNFTS)
        return updatedOrder
    }
    
    /// Fetch user profile
    func fetchProfile(id: Int) async throws -> Profile {
        let profileID: String = String(id)
        
        let selectedProfile: Profile = try await networkService.fetchRequest(endpoint: .profileGetPut, method: .get, id: profileID)
        return selectedProfile
    }
    
    /// Add profile information
    func uploadProfile(by id: String, with profile: Profile) async throws -> Profile {
        let uploadedProfile = UploadProfile(name: profile.name, description: profile.description, website: profile.website, likes: profile.likes)
        
        let updatedProfile: Profile = try await networkService.fetchRequest(endpoint: .profileGetPut, method: .put, id: id, encodableData: uploadedProfile)
        return updatedProfile
    }
    
    /// Fetch all users data
    func fetchUsers() async throws -> [User] {
        try await networkService.fetchRequest(endpoint: .usersGet, method: .get)
    }
    
    /// Fetch user with id
    func fetchUser(by id: String) async throws -> User {
        try await networkService.fetchRequest(endpoint: .userIdGet, method: .get, id: id)
    }
    
    func putLike(profile: Profile) async throws -> Profile {
        try await networkService.fetchRequest(endpoint: .profileGetPut, method: .put, encodableData: profile.likes)
    }
}

