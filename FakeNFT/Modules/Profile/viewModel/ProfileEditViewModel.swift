import Foundation

final class ProfileEditViewModel: ObservableObject {
    
    @Published var nameProfile: String = "Joaquin Phoenix"
    @Published var descriptionProfile: String = """
    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, \
    и еще больше — на моём сайте. Открыт к коллаборациям.
    """
    @Published var websiteProfile: String = "Joaquin Phoenix.com"
    @Published var avatarData: Data? = nil
    
    private let avatarKey: String = "profile_avatar"
    
    init() {
        loadAvatar()
    }
    
    func saveAvatar(data: Data) {
        avatarData = data
        UserDefaults.standard.set(data, forKey: avatarKey)
    }
    
    func loadAvatar() {
        avatarData = UserDefaults.standard.data(forKey: avatarKey)
    }
    
    func saveProfile() {
        //        TODO: Логика сохранения данных профиля
    }
}
