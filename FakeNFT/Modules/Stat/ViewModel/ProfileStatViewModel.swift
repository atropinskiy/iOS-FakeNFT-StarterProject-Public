//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 01.05.2025.
//

import SwiftUI
import Combine

enum SortOrder {
    case none
    case name
    case rating
}

@MainActor
final class ProfileStatViewModel: ObservableObject {
    @Published var sortOrder: SortOrder = .none
//    @Published var profileArray: [ProfileModel] = []
    @Published var allUsersList: [User] = []
    @Published var isLoading: Bool = false

    private let networkService = NetworkServiceFunction.shared

    private var cancellableSet: Set<AnyCancellable> = []

    let profileView1 = ProfileModel(avatar: "alex", name: "Alex", rating: 112, description: "", nfts: [], website: "")
    let profileView2 = ProfileModel(avatar: "", name: "Bill", rating: 98, description: "", nfts: [], website: "")
    let profileView3 = ProfileModel(avatar: "", name: "Alla", rating: 72, description: "", nfts: [], website: "")
    let profileView4 = ProfileModel(avatar: "mads", name: "Mads", rating: 71, description: "", nfts: [], website: "")
    let profileView5 = ProfileModel(avatar: "timothee", name: "Timothee", rating: 51, description: "", nfts: [], website: "")
    let profileView6 = ProfileModel(avatar: "lea", name: "Lea", rating: 23, description: "", nfts: [], website: "")
    let profileView7 = ProfileModel(avatar: "eric", name: "Eric", rating: 11, description: "", nfts: [], website: "")
    let profileView8 = ProfileModel(avatar: "", name: "Nick", rating: 9, description: "", nfts: [], website: "")
    let profileView9 = ProfileModel(avatar: "", name: "Eva", rating: 7, description: "", nfts: [], website: "")

//    var profileStatArray: [ProfileModel] {
//        return [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
//    }

    init() {
//        self.profileArray = [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
        $sortOrder
            .map { [weak self] sortType in
                guard let self else { return [] }
                switch sortType {
                    case .name:
                        return self.allUsersList.sorted { $0.name < $1.name}
                    case .rating:
                        return self.allUsersList.sorted { $0.rating < $1.rating}.reversed()
                    case .none:
                        return self.allUsersList.sorted { $0.rating < $1.rating}.reversed()
                }
            }
            .assign(to: \.allUsersList, on: self)
            .store(in: &cancellableSet)
    }

    func fetchData() {
        print("Начинаю качать список профилей...")
//        profileArray = [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
        isLoading = true
        Task {
            do {
                print("Скачиваю список профилей...")
                let allUsers = try await networkService.fetchUsers()
//                let allProfiles = try await networkService.fetchProfile(id: 1)
//                allUsers[0].
                self.allUsersList = allUsers
//                let singleProfile = try await networkService.fetchProfile(id: 1)
                self.isLoading = false
                print(allUsersList.count)
                print(allUsersList[0].avatar)

            } catch {
                print("Ошибка загрузки списка профилей: \(error.localizedDescription)")
                self.isLoading = false
            }

        }


    }
}
