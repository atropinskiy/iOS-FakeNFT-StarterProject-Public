//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import Foundation

final class ProfileStatViewModel: ObservableObject {
    let profileView1 = ProfileModel(avatar: "alex", name: "Alex", rating: 112)
    let profileView2 = ProfileModel(avatar: "", name: "Bill", rating: 98)
    let profileView3 = ProfileModel(avatar: "", name: "Alla", rating: 72)
    let profileView4 = ProfileModel(avatar: "mads", name: "Mads", rating: 71)
    let profileView5 = ProfileModel(avatar: "timothee", name: "Timothee", rating: 51)
    let profileView6 = ProfileModel(avatar: "lea", name: "Lea", rating: 23)
    let profileView7 = ProfileModel(avatar: "eric", name: "Eric", rating: 11)
    let profileView8 = ProfileModel(avatar: "", name: "Nick", rating: 9)
    let profileView9 = ProfileModel(avatar: "", name: "Eva", rating: 7)

    var profileStatArray: [ProfileModel] {
        return [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
    }

    func fetchData() {
        print("Скачиваю список профилей...")
    }

}
