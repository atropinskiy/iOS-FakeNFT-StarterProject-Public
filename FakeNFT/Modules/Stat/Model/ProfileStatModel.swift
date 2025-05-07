//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import Foundation

struct ProfileModel: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let avatar: String
    let name: String
    let rating: Int
    let description: String
    let nfts: [String]
    let website: String
}

struct ProfileDetailedModel: Codable, Hashable {
    let avatar: String
    let name: String
    let description: String
    let website: String
    let nfts: [String]
}
