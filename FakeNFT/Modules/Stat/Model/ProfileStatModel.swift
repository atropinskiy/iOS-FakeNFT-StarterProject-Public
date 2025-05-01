//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import Foundation

struct ProfileModel: Codable, Identifiable, Hashable {
    var id: UUID
    let avatar: String
    let name: String
    let rating: Int
}
