//
//  EmptyStatView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 27.05.2025.
//

import SwiftUI

struct EmptyStatView: View {
    let title: String
    let imageName: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 48))
                .foregroundStyle(Color(.gray))
            Text(title)
                .font(.title2)
                .bold()
            Text(description)
                .font(.subheadline)
                .foregroundStyle(Color(.gray))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let title: String = "Нет данных"
    let imageName: String = "person.3"
    let description: String = "Не удалось загрузить список пользователей"
    EmptyStatView(title: title, imageName: imageName, description: description)
}
