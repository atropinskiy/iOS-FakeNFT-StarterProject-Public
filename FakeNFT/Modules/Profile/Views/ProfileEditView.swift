import SwiftUI

struct ProfileEditView: View {
    
    @EnvironmentObject var viewModel: ProfileEditViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingImagePicker = false
    @State private var isShowingPhotoOptions = false
    @State private var showCameraAlert = false
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            // Кнопка закрытия
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color(.tBlack))
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding()
            }
            
            // Аватарка
            ZStack {
                if let data = viewModel.avatarData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                } else {
                    Image(.joaquin) // замените на своё изображение
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }
                
                Button {
                    isShowingPhotoOptions = true
                } label: {
                    Text("Сменить\nфото")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(.tWhite))
                        .padding(6)
                }
                .padding(.top, 8)
                .confirmationDialog("Выберите источник", isPresented: $isShowingPhotoOptions, titleVisibility: .visible) {
                    Button("С камеры") {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            imagePickerSource = .camera
                            DispatchQueue.main.async {
                                isShowingImagePicker = true
                            }
                        } else {
                            showCameraAlert = true
                        }
                    }
                    .alert("Камера недоступна", isPresented: $showCameraAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    Button("Из галереи") {
                        imagePickerSource = .photoLibrary
                        DispatchQueue.main.async {
                            isShowingImagePicker = true
                        }
                        
                    }
                    Button("Отмена", role: .cancel) {}
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    // Имя
                    Text("Имя")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $viewModel.nameProfile)
                        .padding()
                        .background(Color(.tLightGray))
                        .cornerRadius(12)
                }
                
                Group {
                    // Описание
                    Text("Описание")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $viewModel.descriptionProfile, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .padding()
                        .background(Color(.tLightGray))
                        .cornerRadius(12)
                }
                
                Group {
                    // Сайт
                    Text("Сайт")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $viewModel.websiteProfile)
                        .padding()
                        .background(Color(.tLightGray))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
        }
        .padding(.top)
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(sourceType: imagePickerSource, selectedImage: $selectedImage)
        }
        .onChange(of: selectedImage) { newImage in
            if let image = newImage,
               let data = image.jpegData(compressionQuality: 0.8) {
                viewModel.saveAvatar(data: data)
            }
        }
    }
}

#Preview {
    ProfileEditView()
        .environmentObject(ProfileEditViewModel())
}

