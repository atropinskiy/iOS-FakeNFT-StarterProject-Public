//
//  CatalogCollectionGrid.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI

struct CatalogCollectionGridView: View {
    let images = ["MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg", "MockNFTImg"] // Ваши изображения
    
    let columns = [
        GridItem(.flexible()),  // Первый столбец
        GridItem(.flexible()),  // Второй столбец
        GridItem(.flexible())   // Третий столбец
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {  // Настройка грид
            ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                CatalogGridCell(imgName: image)
            }
        }
        .padding()  // Добавляем отступы для грид
    }
}
