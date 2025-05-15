import Foundation

final class ProfileEditViewModel: ObservableObject {
    
    @Published var nameProfile: String = "Joaquin Phoenix"
    @Published var descriptionProfile: String = """
    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, \
    и еще больше — на моём сайте. Открыт к коллаборациям.
    """
    @Published var websiteProfile: String = "Joaquin Phoenix.com"
    
    //    Поля для редактирования
    
    @Published var editingNameProfile: String = ""
    @Published var editingDescriptionProfile: String = ""
    @Published var editingWebsiteProfile: String = ""
    
    
    init() {
        loadProfile()
    }
    
    func loadProfile() {
        editingNameProfile = nameProfile
        editingDescriptionProfile = descriptionProfile
        editingWebsiteProfile = websiteProfile
    }
    
    func saveProfile() {
        nameProfile = editingNameProfile
        descriptionProfile = editingDescriptionProfile
        websiteProfile = editingWebsiteProfile
    }
}
