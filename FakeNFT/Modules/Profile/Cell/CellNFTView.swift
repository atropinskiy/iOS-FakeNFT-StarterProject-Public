import SwiftUI

struct ProductCardView: View {
    @State private var rating: Int = 0

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                Image("lilo") // Замените на ваше изображение
                    .resizable()
                    .background(.gray)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)

                Image(systemName: "heart.fill")
                    .foregroundColor(Color(.tWhite))
                    .padding(6)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Lilo")
                    .font(.headline)

                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .foregroundColor(index <= rating ? .yellow : .gray)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                .font(.caption)

                Text("от John Doe")
                    .font(.subheadline)
                    .foregroundStyle(Color(.tBlack))
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Цена")
                    .font(.subheadline)
                    .foregroundStyle(Color(.tBlack))

                Text("1,78 ETH")
                    .font(.headline)
                    .bold()
            
            }
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView()
            .previewLayout(.sizeThatFits)
    }
}

