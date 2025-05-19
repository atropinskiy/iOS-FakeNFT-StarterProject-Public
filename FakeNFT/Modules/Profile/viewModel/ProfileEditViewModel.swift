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
    @Published var isSaving: Bool = false
    
    
    init() {
        loadProfile()
    }
    
    func loadProfile() {
        editingNameProfile = nameProfile
        editingDescriptionProfile = descriptionProfile
        editingWebsiteProfile = websiteProfile
    }
    
    func saveProfile(completion: @escaping () -> Void) {
        isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            nameProfile = editingNameProfile
            descriptionProfile = editingDescriptionProfile
            websiteProfile = editingWebsiteProfile
            isSaving = false
            completion()
        }
    }
}
