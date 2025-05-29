import Foundation

enum SortOption {
    case name
    case rating
    case price
}

@MainActor
final class ProfileEditViewModel: ObservableObject {
    @Published var profile: Profile = Profile(
        name: "",
        avatar: "",
        description: "",
        website: "",
        nfts: [],
        likes: [],
        id: ""
    )
    @Published var myLoadedNFTs: [NFT] = []
    @Published var myFavNFTS: [NFT] = []
    @Published var isLoading: Bool = false
    @Published var isSaving: Bool = false
    @Published var loadProfileErrorMessage: String?
    @Published var saveProfileErrorMessage: String?
    
    private var isFetching = false
    private let networkService = NetworkServiceFunction.shared
    private let profileId: Int = 1
        
    func loadProfile() async {
        await fetchDataFromProfile()
    }
    
    private func fetchDataFromProfile() async {
        guard !isFetching else { return }
        isFetching = true
        defer { isFetching = false }
        isLoading = true
        loadProfileErrorMessage = nil
        
        do {
            let loadedProfile = try await networkService.fetchProfile(id: profileId)
            self.profile = loadedProfile
            var loadedNFTs: [NFT] = []
            var favNfts: [NFT] = []
            
            for nftId in profile.nfts {
                let myNFTs = try await networkService.fetchNft(with: nftId)
                loadedNFTs.append(myNFTs)
            }
            
            for nftId in profile.likes {
                let myNFTs = try await networkService.fetchNft(with: nftId)
                favNfts.append(myNFTs)
            }
            self.myLoadedNFTs = loadedNFTs
            self.myFavNFTS = favNfts
            
        } catch {
            loadProfileErrorMessage = "Не удалось загрузить профиль: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func saveProfile() async {
        isSaving = true
        saveProfileErrorMessage = nil
        
        let savedProfile = Profile(
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website,
            nfts: profile.nfts,
            likes: profile.likes,
            id: profile.id
        )
        
        do {
            _ = try await networkService.uploadProfile(by: String(profileId), with: savedProfile)
        } catch {
            saveProfileErrorMessage = "Не удалось сохранить профиль: \(error.localizedDescription)"
        }
        isSaving = false
    }
    
    func isInFavorites(_ nftId: String) -> Bool {
        return myFavNFTS.contains(where: { $0.id == nftId })
    }
    
    func favoriteAddRemove(nft: NFT) async {
        if myFavNFTS.firstIndex(of: nft) != nil {
            myFavNFTS.removeAll(where: { $0 == nft } )
        } else {
            myFavNFTS.append(nft)
        }
        await updateFavorites()
    }
    
    func updateFavorites() async {
        
        let likesArray: [String] = myFavNFTS.map { $0.id }
        profile.likes = likesArray
        
        Task {
            guard profile.id != "" else {
                print("Ошибка: текущий профиль не найден")
                return
            }
            do {
                let _ = try await networkService.putLike(profile: profile)
            } catch {
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }

    func sortNFTs(by option: SortOption) {
        switch option {
            case .name:
                myLoadedNFTs.sort { $0.name < $1.name }
            case .rating:
                myLoadedNFTs.sort { $0.rating > $1.rating } // рейтинг по убыванию?
            case .price:
                myLoadedNFTs.sort { $0.price < $1.price }
        }
    }
}



