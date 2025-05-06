import Foundation

final class ProfileEditViewModel: ObservableObject {
    
    @Published var nameProfile: String = "Joaquin Phoenix"
    @Published var descriptionProfile: String = """
    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, \
    и еще больше — на моём сайте. Открыт к коллаборациям.
    """
    @Published var websiteProfile: String = "Joaquin Phoenix.com"
    
    
    func saveProfile() {
//        TODO: Логика сохранения данных профиля
    }
}
