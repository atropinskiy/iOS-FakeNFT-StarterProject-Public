//
//  NetworkModel.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 29.04.2025.
//

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

