//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import Foundation

final class ProfileStatViewModel: ObservableObject {
    let profileView1 = ProfileModel(avatar: "alex", name: "Alex", rating: 112, description: "", nfts: [], website: "")
    let profileView2 = ProfileModel(avatar: "", name: "Bill", rating: 98, description: "", nfts: [], website: "")
    let profileView3 = ProfileModel(avatar: "", name: "Alla", rating: 72, description: "", nfts: [], website: "")
    let profileView4 = ProfileModel(avatar: "mads", name: "Mads", rating: 71, description: "", nfts: [], website: "")
    let profileView5 = ProfileModel(avatar: "timothee", name: "Timothee", rating: 51, description: "", nfts: [], website: "")
    let profileView6 = ProfileModel(avatar: "lea", name: "Lea", rating: 23, description: "", nfts: [], website: "")
    let profileView7 = ProfileModel(avatar: "eric", name: "Eric", rating: 11, description: "", nfts: [], website: "")
    let profileView8 = ProfileModel(avatar: "", name: "Nick", rating: 9, description: "", nfts: [], website: "")
    let profileView9 = ProfileModel(avatar: "", name: "Eva", rating: 7, description: "", nfts: [], website: "")

    var profileStatArray: [ProfileModel] {
        return [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
    }

    func fetchData() {
        print("Скачиваю список профилей...")
    }
}
