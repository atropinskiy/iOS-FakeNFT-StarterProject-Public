//
//  NetworkModel.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 29.04.2025.
//

struct Collection: Codable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
    let id: String
}

struct NFT: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}

struct Currency: Codable {
    let title: String
    let name: String
    let image: String
    let id: String
}

struct Order: Codable {
    let nfts: [String]
    let id: String
}

struct Payment: Codable {
    let success: Bool
    let orderId: String
    let id: String
}

struct Profile: Codable {
    var name: String
    var avatar: String
    var description: String
    var website: String
    var nfts: [String]
    var likes: [String]
    var id: String
}

struct User: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}

struct NFTToCart: Encodable {
    let nfts: [String]
}

struct UploadProfile: Encodable {
    let name: String
    let description: String
    let website: String
    let likes: [String]
}
