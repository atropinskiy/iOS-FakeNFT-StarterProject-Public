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
                    Task {
                        await viewModel.saveProfile()
                        dismiss()
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color(.tBlack))
                        .font(.system(size: 20, weight: .semibold))
                }
                .disabled(viewModel.isSaving)
                .padding()
            }
            
            // Аватарка
            ZStack {
                Image(.joaquin)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
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
                    TextField("", text: $viewModel.editedName)
                        .padding()
                        .background(Color(.tLightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Group {
                    // Описание
                    Text("Описание")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $viewModel.editedDescription, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .padding()
                        .background(Color(.tLightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Group {
                    // Сайт
                    Text("Сайт")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $viewModel.editedWebsite)
                        .padding()
                        .background(Color(.tLightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
        }
        .padding(.top)
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(sourceType: imagePickerSource, selectedImage: $selectedImage)
        }
        .onAppear {
            Task {
                await viewModel.loadProfile()
            }
        }
        .overlay {
            if viewModel.isSaving {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    ProgressView()
                        .padding()
                        .foregroundStyle(Color(.tBlack))
                        .background(Color(.tLightGray))
                        .clipShape(RoundedRectangle(cornerRadius: 12))                }
            }
        }
    }
}

#Preview {
    ProfileEditView()
        .environmentObject(ProfileEditViewModel())
}


