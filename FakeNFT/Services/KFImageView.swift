//
//  Untitled.swift
//  FakeNFT
//
//  Created by alex_tr on 02.05.2025.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    let urlString: String
    var placeholder: AnyView = AnyView(ProgressView())
    var fallbackImage: Image = Image(systemName: "photo")
    var contentMode: SwiftUI.ContentMode = .fill
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var cornerRadius: CGFloat = 0

    var body: some View {
        if let url = URL(string: urlString) {
            KFImage(url)
                .resizable()
                .placeholder {
                    placeholder
                }
                .aspectRatio(contentMode: contentMode)
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
                .clipped()
        } else {
            fallbackImage
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
                .foregroundColor(.gray.opacity(0.5))
        }
    }
}
