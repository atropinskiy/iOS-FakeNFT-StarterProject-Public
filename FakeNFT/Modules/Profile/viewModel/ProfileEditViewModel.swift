import Foundation

@MainActor
final class ProfileEditViewModel: ObservableObject {
    @Published var profile: Profile = Profile(name: "", avatar: "", description: "", website: "", nfts: [], likes: [], id: "")
    @Published var myloadedNFTs: [NFT] = []
    @Published var myFavNFTS: [NFT] = []
    @Published var isLoading: Bool = false
    @Published var isSaving: Bool = false
    @Published var loadProfileErrorMessage: String?
    @Published var saveProfileErrorMessage: String?
    
    var editedName = ""
    var editedDescription = ""
    var editedWebsite: String = ""
    var editedLikes: [String] = []
    
    private let networkService = NetworkServiceFunction.shared
    private let profileId: Int = 1
    
    init() {
        Task {
            await loadProfile()
        }
    }
    
    func loadProfile() async {
            await fetchDataFromProfile()
    }
    
    private func fetchDataFromProfile() async {
        isLoading = true
        loadProfileErrorMessage = nil
        
        do {
            let loadedProfile = try await networkService.fetchProfile(id: profileId)
            editedName = loadedProfile.name
            editedDescription = loadedProfile.description
            editedWebsite = loadedProfile.website
            editedLikes = loadedProfile.likes
            profile = loadedProfile
            
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
            
            myloadedNFTs = loadedNFTs
            myFavNFTS = favNfts
            
            
        } catch {
            loadProfileErrorMessage = "Не удалось загрузить профиль: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func saveProfile() async {
        isSaving = true
        saveProfileErrorMessage = nil
        
        let savedProfile = Profile(name: editedName, avatar: profile.avatar, description: editedDescription, website: editedWebsite, nfts: profile.nfts, likes: editedLikes, id: profile.id)
        
        do {
            _ = try await networkService.uploadProfile(by: String(profileId), with: savedProfile)
        } catch {
            saveProfileErrorMessage = "Не удалось сохранить профиль: \(error.localizedDescription)"
        }
        isSaving = false
    }
}

