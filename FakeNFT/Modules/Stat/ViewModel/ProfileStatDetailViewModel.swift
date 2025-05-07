//
//  ProfileStatDetailViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 07.05.2025.
//

import Foundation

final class ProfileStatDetailViewModel: ObservableObject {
    let profileDetails: ProfileDetailedModel = .init(avatar: "alexLarge",
                                                     name: "Joaquin Phoenix",
                                                     description: """
                                                     Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.
                                                     """,
                                                     website: "",
                                                     nfts: [])
}
