//
//  CartModel.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

struct Order: Codable {
    let nfts: [String]
    let id: String
}

struct NFT: Codable, Identifiable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}

