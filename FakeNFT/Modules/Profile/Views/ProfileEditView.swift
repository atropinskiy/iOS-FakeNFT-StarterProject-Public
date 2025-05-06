import SwiftUI

struct ProfileEditView: View {

    @EnvironmentObject var viewModel: ProfileEditViewModel
    @Environment(\.dismiss) private var dismiss

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
            VStack {
                Image(.joaquin) // замените на своё изображение
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(
                        Text("Сменить\nфото")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(.tWhite))
                            .padding(6),
                        alignment: .center
                    )
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

            // Навигационная полоса
            Rectangle()
                .frame(width: 134, height: 5)
                .cornerRadius(2.5)
                .foregroundStyle(.black.opacity(0.8))
                .padding(.bottom, 8)
        }
        .padding(.top)
    }
}

#Preview {
    ProfileEditView()
        .environmentObject(ProfileEditViewModel())
}

