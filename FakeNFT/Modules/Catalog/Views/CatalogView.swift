//
//  CatalogView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel = CatalogViewModel()
    
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            
        }
        Text("Тут каталог")
    }
}

#Preview {
    CatalogView()
}
