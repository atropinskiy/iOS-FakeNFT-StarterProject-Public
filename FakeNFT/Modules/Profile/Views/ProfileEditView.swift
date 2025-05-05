import SwiftUI

struct ProfileEditView: View {
    @State private var name: String = "Joaquin Phoenix"
    @State private var description: String = """
    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, \
    и еще больше — на моём сайте. Открыт к коллаборациям.
    """
    @State private var website: String = "Joaquin Phoenix.com"
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
                        .foregroundColor(.black)
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
                            .foregroundColor(.white)
                            .padding(6),
                        alignment: .center
                    )
            }

            VStack(alignment: .leading, spacing: 16) {
                Group {
                    // Имя
                    Text("Имя")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $name)
                        .padding()
                        .background(Color(.tLightGray))
                        .cornerRadius(12)
                }

                Group {
                    // Описание
                    Text("Описание")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $description, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .padding()
                        .background(Color(.tLightGray))
                        .cornerRadius(12)
                }

                Group {
                    // Сайт
                    Text("Сайт")
                        .font(.system(size: 18, weight: .bold))
                    TextField("", text: $website)
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
                .foregroundColor(.black.opacity(0.8))
                .padding(.bottom, 8)
        }
        .padding(.top)
    }
}

#Preview {
    ProfileEditView()
}

