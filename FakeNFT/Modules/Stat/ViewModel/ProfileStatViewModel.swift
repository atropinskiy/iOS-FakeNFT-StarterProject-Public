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
    @Published var nftsInFavorites: [String] = []
    @Published var nftsInCart: [String] = []
    private var profile: Profile?

    private let networkService = NetworkServiceFunction.shared
    private var cancellableSet: Set<AnyCancellable> = []

    //    let profileView1 = ProfileModel(avatar: "alex", name: "Alex", rating: 112, description: "", nfts: [], website: "")
    //    let profileView2 = ProfileModel(avatar: "", name: "Bill", rating: 98, description: "", nfts: [], website: "")
    //    let profileView3 = ProfileModel(avatar: "", name: "Alla", rating: 72, description: "", nfts: [], website: "")
    //    let profileView4 = ProfileModel(avatar: "mads", name: "Mads", rating: 71, description: "", nfts: [], website: "")
    //    let profileView5 = ProfileModel(avatar: "timothee", name: "Timothee", rating: 51, description: "", nfts: [], website: "")
    //    let profileView6 = ProfileModel(avatar: "lea", name: "Lea", rating: 23, description: "", nfts: [], website: "")
    //    let profileView7 = ProfileModel(avatar: "eric", name: "Eric", rating: 11, description: "", nfts: [], website: "")
    //    let profileView8 = ProfileModel(avatar: "", name: "Nick", rating: 9, description: "", nfts: [], website: "")
    //    let profileView9 = ProfileModel(avatar: "", name: "Eva", rating: 7, description: "", nfts: [], website: "")

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
        //        var counter = 0
        print("Начинаю качать список профилей...")
        //        profileArray = [profileView1, profileView2, profileView3, profileView4, profileView5, profileView6, profileView7, profileView8, profileView9]
        isLoading = true
        Task {
            do {
                print("Скачиваю список профилей...")
                let allUsers = try await networkService.fetchUsers()
                //                let allProfiles = try await networkService.fetchProfile(id: 1)
                self.allUsersList = allUsers
                //                let singleProfile = try await networkService.fetchProfile(id: 1)
                self.isLoading = false
                print("Найдено профилей:", allUsersList.count)
                //                allUsersList.forEach {
                //                    counter += 1
                //                    print("\(counter)", $0.name, $0.avatar)
                //                }
                //                print(allUsersList[0].avatar)

            } catch {
                print("Ошибка загрузки списка профилей: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }

    //    func fetchCurrentProfile() async {
    //        Task { @MainActor in
    //            do {
    //                let profile = try await networkService.fetchProfile(id: 1)
    //                self.profile = profile
    //            } catch {
    //                print("Ошибка загрузки профиля: \(error)")
    //            }
    //        }
    //    }

    func fetchFavoriteAndCart() async {
        //        isLoading = true
        //        Task { @MainActor in
        do {
            let profile = try await networkService.fetchProfile(id: 1)
            let order = try await networkService.fetchOrder(by: "1")
            //            let order = try await networkService.fetchOrder(by: profile.name)
            await MainActor.run {
                //                guard let profile else { return }
                self.profile = profile
                self.nftsInFavorites = profile.likes
                self.nftsInCart = order.nfts
                //                self.isLoading = false
                print("NFTs в избранном:", self.nftsInFavorites)
                print("NFTs в Корзине:", self.nftsInCart)
            }
        } catch {
            await MainActor.run {
                print("Ошибка загрузки Избранного и Корзины: \(error)")
                //                self.isLoading = false
            }
        }
    }

    func toggleFavorites(nft: NFT) async {
        print("1 Favorites: \(nftsInFavorites)")
        print("1 Profile:", profile?.likes)

        if nftsInFavorites.firstIndex(of: nft.id) != nil {
            print("Убрать из избранного: \(nft.id), nft.name: \(nft.name)")
            nftsInFavorites.removeAll(where: { $0 == nft.id } )
            print("Updated nftsInFavorites - removal", nftsInFavorites)
        } else {
            print("Добавить в избранное: \(nft.id), nft.name: \(nft.name)")
            nftsInFavorites.append(nft.id)
            print("Updated nftsInFavorites - adding", nftsInFavorites)
        }
        print("2 Favorites: \(nftsInFavorites)")
        print("2 Profile:", profile?.likes)
        await updateFavorites()
    }

    //        private func updateFavorites() async {
    //            Task { @MainActor in
    //                do {
    //                    guard var profile else { return }
    //                    print("Old profile:", profile.likes)
    //                    profile.likes = self.nftsInFavorites
    //                    let newProfile = try await networkService.uploadProfile(by: "1", with: profile)
    //
    //                    print("Обновлено избранное:", self.nftsInFavorites)
    //                    print("New profile:", newProfile.likes)
    //                } catch {
    //                    print("Ошибка обновления Избранного: \(error)")
    //                }
    //            }
    //        }

    private func updateFavorites() async {
        do {
            guard var profile else { return }
            print("Old profile:", profile.likes)
            profile.likes = self.nftsInFavorites
            let newProfile = try await networkService.uploadProfile(by: "1", with: profile)
            await MainActor.run {
                print("Обновлено избранное:", self.nftsInFavorites)
                print("New profile:", newProfile.likes)
            }
        } catch {
            await MainActor.run {
                print("Ошибка обновления Избранного: \(error)")
            }
        }
    }

    private func updateCart() async {
        Task { @MainActor in
            do {
                guard var profile else { return }
                print("Old profile:", profile)
                profile.likes = nftsInFavorites
                let newProfile = try await networkService.uploadProfile(by: "1", with: profile)
                print("New profile:", newProfile)

                //                print("Обновлено Избранное:", self.nftsInFavorites)
                print("Обновлена Корзина:", self.nftsInCart)
            } catch {
                print("Ошибка обновления Корзины: \(error)")
                //                self.isLoading = false
            }
        }
    }

}
